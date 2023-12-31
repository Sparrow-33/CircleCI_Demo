public class JsonMapper {
    //
//Generated by AdminBooster
//
	public Integer total_count;	//50027712
	public cls_links[] links;
	public cls_records[] records;
	public class cls_links {
		public String rel;	//self
		public String href;	//https://erdf.opendatasoft.com/api/v2/catalog/datasets/conso-sup36-region/records/6bfef9ae43c2957b8ee2a081196853fe882c1f9f
	}
	public class cls_records {
		public cls_links[] links;
		public cls_record record;
	}
	public class cls_record {
		public String id;	//6bfef9ae43c2957b8ee2a081196853fe882c1f9f
		public String timestamp;	//2021-04-28T11:49:46.498Z
		public Integer size;	//144
		public cls_fields fields;
	}
	public class cls_fields {
		public String horodate;	//2021-01-14T00:30:00+00:00
		public String region;	//Pays de la Loire
		public String code_region;	//52
		public String profil;	//ENT1 (+ ENT2)
		public String plage_de_puissance_souscrite;	//P4: ]250-1000] kVA
		public String secteur_activite;	//S2: Industrie
		public Decimal nb_points_soutirage;	//3
		public Decimal total_energie_soutiree_wh;	//77666
		public Decimal courbe_moyenne_ndeg1_wh;
		public String indice_representativite_courbe_ndeg1;	//S
		public Decimal courbe_moyenne_ndeg2_wh;
		public String indice_representativite_courbe_ndeg2;	//S
		public Decimal courbe_moyenne_ndeg1_ndeg2_wh;	//25888
		public String indice_representativite_courbe_ndeg1_ndeg2;	//0
		public String jour_max_du_mois_0_1;	//0
		public String semaine_max_du_mois_0_1;	//0
	}
	public class cls_courbe_moyenne_ndeg1_wh {
	}
	public class cls_courbe_moyenne_ndeg2_wh {
	}
	public static JsonMapper parse(String json){
		return (JsonMapper) System.JSON.deserialize(json, JsonMapper.class);
	}

	
}