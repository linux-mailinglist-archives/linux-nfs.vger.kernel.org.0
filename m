Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9939C5F1D36
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Oct 2022 17:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiJAPeG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 1 Oct 2022 11:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiJAPeF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 1 Oct 2022 11:34:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6F43B708
        for <linux-nfs@vger.kernel.org>; Sat,  1 Oct 2022 08:34:03 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 291B4K7Y002428;
        Sat, 1 Oct 2022 15:33:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=U52iGOeh52vAfk86EEw0LR/ffFpzddRHvGaseSqkL3c=;
 b=rGmbo9jtovDN/1Mm4LmcxSZg2WSmATvNeF5SfgHHHtfmYOtUjkFFHEXckkIY47QBftbO
 t7Z0yW+RYnigQ8sbNkkeeOhtOEa3bFsA8Wpp2TyfibaP0rMB1iYJ/2eoOli+It7Nk2G8
 HTmeWcS3LpXOLvDyb+PZVHlJaluzXjd8G6577dWEnaisfyNr4z9nS+jqNTfUvSjPRglU
 oY2w0tFW/j8sVMz4JMD1l2WZ9rrSADtiIcjUKN+FdezWu2VqVMhfUBlT7vj65yqoDTbE
 tTEjWV44wSQhYx5B7URLqGRnonpcQccMhjx51zsgv3SsynZ+ZoBAlgWQi9elk2yp6+U4 Rw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxdea0pcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 01 Oct 2022 15:33:56 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29190LcF033795;
        Sat, 1 Oct 2022 15:33:55 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc087267-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 01 Oct 2022 15:33:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETyrKfTiv4/wOfc1bPUgu6o79Rr3ikhSTI5qfKqmyQQh8IHjXb5KIBKT4bH+8I2vSrvTQMEMmsLDNayAKH2katv/OzRUva3/ovQCG5RlS8Y/FSGX4LoAPuwi0YKWCAOEdtu8DGH/N57fVNr11+UZBnNjSL14gVJ0U/5Ty/CgDjtXG4hkgUqUW8r7/LlGHU1yfAMjMIUYyAx0Yy/1gD2W79cltTmGoDLobTzrG5g/2GtEZcL2PqQDyNlIYyKvWL4kHpeF99oU6X4tOXe7SXREML61Wuzb1OcYh6viNt4oTBGTokkvSMutTl5/pc2+Tyydu0biy2fYzoF4Hb2Lezj71A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U52iGOeh52vAfk86EEw0LR/ffFpzddRHvGaseSqkL3c=;
 b=OQImBakDqfAKSY+AsL//AlpVra4sWqu+lhAfBo0m8LZXcaoBUGGw1hnFE5f8/ZxnnDcCmi4KRIwpcJyzcFws2wx1F0Eo39SfkSV0LtbJSfxnRGbzHFs2MIJ5uLRutlL+3v5Hbw3smkluld23FdxsVS5TH5KKFGLIspKHIip0GvtmbWPQZ0Ucrj7Caiof6ekajuTwH71/OcEPTG1nbpr+WPjRJVY/sNEnHHzXRuAPeYvSB43DZgf2IUwssoKPGnvEk8z7YiI3aKNEuWGz8TE1D+I5j0tP7sOVAw3Qp1WU3asHMAIU28kVn1mEQpY/9Gf0NmfeHMMPLSNaqjNJhLelEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U52iGOeh52vAfk86EEw0LR/ffFpzddRHvGaseSqkL3c=;
 b=ew5FiwBO1Ys4lup3H8Jj+SP7dCsTTJ1LdnHE7EBod5Kb32lgwFwyZSzdAAFO7NtsMyt+viv3475PZlIN6jYqpuZ7KcJNPOjWV1scYxRGSHafI1q+MITW+LjHo080TqR4oWGCWdM4oVWK/mZVk43b5VIwMgpDXVcc8Vof+W+IFgw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4612.namprd10.prod.outlook.com (2603:10b6:303:9b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Sat, 1 Oct
 2022 15:33:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5676.024; Sat, 1 Oct 2022
 15:33:53 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Subject: Re: [PATCH v2] nfsd: nfsd_do_file_acquire should hold rcu_read_lock
 while getting refs
Thread-Topic: [PATCH v2] nfsd: nfsd_do_file_acquire should hold rcu_read_lock
 while getting refs
Thread-Index: AQHY1Xx83NLvB6RPo0qCB3ayozGSka35q3EA
Date:   Sat, 1 Oct 2022 15:33:53 +0000
Message-ID: <CD650F11-FFCE-46A3-90B8-45C742D8B670@oracle.com>
References: <20221001095918.7546-1-jlayton@kernel.org>
In-Reply-To: <20221001095918.7546-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO1PR10MB4612:EE_
x-ms-office365-filtering-correlation-id: 809f2204-0cf0-4f0d-b31e-08daa3c2589a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d4QBfrAxYQOsFziZfSWkEJGPV2l0dKe7gu2gAnB9Xq6lNNgOaHQuXntoEcjpwaWHytAxVF2rMMpr9TbdHlT0MiiTQJj3zYBd0uf4YyxPX2qhQlJqQoif48oG1O6/K2Rz1I046wj0ftNiAY9kIg30AkwLL5X0WGCa8aCgWw1/GA63vTbKc3GaKF8vTHUCh/JN7Nr1JXlSYWXqT28AII6gxCVnKaWO3luDCfrJR0qEVh5PA0rXXVWkfG3TDZht7zDXvhNnSDsDkMrzfaKWt7kuLn19e00IWe+LzuTXeBdXPWrRcNV0tEYrTEl/5afwGfDrYgxa+tXDHUpW3S4Z68iPoCMJcwq3eOtc9Z5oFGXWfunzy4dKKasat+dnXgrlaQ78EP4JcrWb3oNO3TQsNjq5PgB+DybvZBNqP6dp08QZKwKhiVexmMmSIuoqVpbYqOAd9U2/ohCsVSNM+9BDlDpBEluY89inPWZwQGmow+GsRxrIi+qsPeT5fZ2lYooKYYJwog4rNE0m65qtTBiVCXei0FEG/2XkBMlkA2Fe6hA0nXDzbxi6CDiBU2hCw0sQlK/98Us3q7wEfVSSuD9HDcBSM67X2bcVGIVPn5fVbpkuL6x6uim19XhFmLfT6GZJbU1EFcIaOTAi7ehAKt74fw+NaZhiVax12Mj9ALrDneHcXH2KSgua2v5AMwGFPDsuf16HS9KuWFf9d8q9Sb9PN0aP8p1K3x2tH8r11DPJPo7ZHRlCQK8U3XDzdX3FBC29I1ycJ703GFqsGrFrCsBFmCsJkraBtbV0E2CDBjqdwnxXPK8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199015)(71200400001)(478600001)(2616005)(8936002)(186003)(33656002)(91956017)(2906002)(38070700005)(5660300002)(122000001)(66556008)(76116006)(4326008)(66946007)(66476007)(66446008)(64756008)(8676002)(316002)(6512007)(54906003)(6506007)(6916009)(26005)(53546011)(36756003)(6486002)(83380400001)(41300700001)(38100700002)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bDpJRAAZdT6IVYFW/N1hgheKzDFeikQoBcs0oP9x2AR+C/oBVYH2pjaQSNzN?=
 =?us-ascii?Q?PmMTadPR1Sgtyku7vk6vM7V4RxhNNypdwB9ArVzuzNSlxro0HkO3cKfEICVG?=
 =?us-ascii?Q?fnHEaDTCzCp8wE3Jp7QNm5OpD3DfxDhBkAceBIwtUvnP4AZDiaqpgn1STr64?=
 =?us-ascii?Q?bUgx5/JAiySVDNEsST8GLB8hZrzlvhggaagex9raeRdVAwj+M7xXZOBAZUEd?=
 =?us-ascii?Q?kCQKuuTYTJCwdPA/QSONuxo6G/8X9634/G+x7AP4M4fIcS7UpxO11eR1cYGL?=
 =?us-ascii?Q?5AM0Jhs7eljMVCqDFFHSwryB0aps7kYGt7C9PzztCyBulXfg16wktK2xTpm2?=
 =?us-ascii?Q?wm4K+gd6F1EPgI50ZwzY3exiz2f1jNdabejIhA3j386tA1wm7ckaEZLBkkf+?=
 =?us-ascii?Q?jaoiwoeKCKZzlC1DIJIHD6nFWKliTJXsZ8+ff/8tdmTlnqX65jHN/fL1QYHx?=
 =?us-ascii?Q?eXNYeieqi+Dxn1FepKw9uxVWwVEofTZnpkGoMAsojcZ9MxI6xtDzmYicJSfp?=
 =?us-ascii?Q?iwqKQNEsfSnjsVO5BD//gcNRoABqdbX4stN3E+G+YpX6n8JyE119OvT1rujG?=
 =?us-ascii?Q?/sA9/mSJguqui1r+89iIDoLQGNC5J4zdml3D3KXDoZ6tfUayDqLxGVwr57HG?=
 =?us-ascii?Q?M+N6Juoygifu5m0YurCOa0YYtps1K05tKLEORllqpxGo+/APrzJh5A1xh7Ql?=
 =?us-ascii?Q?uAvrl8Hu2MTKdFGlvENW1lrwBGNkLM9QlexhF1b4jOiHK+i9JFa58r76r388?=
 =?us-ascii?Q?yppWS3JSNQB9UGorAyE42U66j5A1kUiFJuwtN1sPB0dYKyLE7j+uG3U2/WIQ?=
 =?us-ascii?Q?UYb3pAKAHe2MToZYeFIx9szrfBCVf5NnCgOBoC3TBK8j/lr+sBlv3KZoG0JV?=
 =?us-ascii?Q?ohUvFNlN3IdBowYGzvHwZcn4fjXhNRVE25YyT+x88pRgGu5TlSMY36z3b2PB?=
 =?us-ascii?Q?lPlaj5E9RDiTjFDLVgzWsZp5ZIP4g/sSIgNQGCTF96v7uP+kk/l570IT6Tnr?=
 =?us-ascii?Q?0xyxLlc1jqldAIMjmvXIzQ0Ux9kK9YG5VvTBo4j3POGkFVAMdujbp2rMpyso?=
 =?us-ascii?Q?+UN51l5O10vC9xfPMxQJgVt/B3f7IuxizUMH20d5vF2Ye1GeUxocRO0ykYnt?=
 =?us-ascii?Q?FF+gpw/dhEpi+GQ6wpjfQbLSMUwBc3qoNZycwzk7XTehh/aMVPaORkdPeyr2?=
 =?us-ascii?Q?6F/DqR80eY8k4j2tPvPC2iztXTOzo7Ik547HhaGpLz02mdjbK93hxkFMGQKV?=
 =?us-ascii?Q?0LBkenr+Sl1uzXXG+UvR/WakptC/nyPXKC+hezx0drjBJGe0FB7uPSGwYsTV?=
 =?us-ascii?Q?5GhT2ejrs0f3ItfQFm3gBQ9sqcOdXVaxRqXJ1A5uakOmNB6rL+6AlZXdEAO8?=
 =?us-ascii?Q?SDNH1lbluRGBf87f4c9uLEeSOd8/KERTdSpbsBZhEyfWwxanAOEeMwQ8x7dZ?=
 =?us-ascii?Q?3+eadXT3NAruJZ0UH4l3byJByKsGyLERztlN4xKYI+t3/AROXI4gqukdH2px?=
 =?us-ascii?Q?jni1WyB0Fo7vcLOp7zkKHP6ltFz9/qu4hiVeaz0ASYpSPeI/WUGeLSxGPrZ8?=
 =?us-ascii?Q?ktLxmtPvgKyUrA5+9VErDlMy0GM74WBpSQVmxISj9FoiI7n9kxCwPooUCbbB?=
 =?us-ascii?Q?bQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9EBC1DAE6B52104899B5B5C9E9A2BCE5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 809f2204-0cf0-4f0d-b31e-08daa3c2589a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2022 15:33:53.1706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 92rLy/+l5Xp4Vos5gScEYiFAjqadOfMsQIm9tO0KK0o4tZ9TMKpIfADBS+3nLkTjPSRZcQ/vO0Pux06IQKIq4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4612
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-01_10,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210010100
X-Proofpoint-GUID: 43MqDo43_3-fKriBAxwW9XnadrbVzLIV
X-Proofpoint-ORIG-GUID: 43MqDo43_3-fKriBAxwW9XnadrbVzLIV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Jeff-

> On Oct 1, 2022, at 5:59 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> nfsd_file is RCU-freed, so it's possible that one could be found that's
> in the process of being freed and the memory recycled. Ensure we hold
> the rcu_read_lock while attempting to get a reference on the object.

I'm OK with entertaining clean-up patches in this code, but I
am skeptical that this patch addresses the concern enumerated
in bug #394. As you've pointed out to me before, the "UAF on
DELEGRETURN crashes" appeared well before v5.19, which is the
kernel release where this bit of code was introduced.


> Cc: NeilBrown <neilb@suse.de>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/filecache.c | 14 ++++++++------
> 1 file changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index d5c57360b418..f4f75ae2e4ea 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -1077,10 +1077,12 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
>=20
> retry:
> 	/* Avoid allocation if the item is already in cache */
> +	rcu_read_lock();
> 	nf =3D rhashtable_lookup_fast(&nfsd_file_rhash_tbl, &key,
> 				    nfsd_file_rhash_params);
> 	if (nf)
> 		nf =3D nfsd_file_get(nf);
> +	rcu_read_unlock();

Again:

 657 static inline void *rhashtable_lookup_fast(
 658         struct rhashtable *ht, const void *key,
 659         const struct rhashtable_params params)
 660 {
 661         void *obj;
 662=20
 663         rcu_read_lock();
 664         obj =3D rhashtable_lookup(ht, key, params);
 665         rcu_read_unlock();
 666=20
 667         return obj;
 668 }

Since rhashtable_lookup() itself is a public API, please
just call that in nfsd_file_do_acquire() after explicitly
taking the RCU read lock.


> 	if (nf)
> 		goto wait_for_construction;
>=20
> @@ -1090,21 +1092,21 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, stru=
ct svc_fh *fhp,
> 		goto out_status;
> 	}
>=20
> +	rcu_read_lock();
> 	nf =3D rhashtable_lookup_get_insert_key(&nfsd_file_rhash_tbl,
> 					      &key, &new->nf_rhash,
> 					      nfsd_file_rhash_params);
> +	if (!IS_ERR_OR_NULL(nf)) {
> +		nf =3D nfsd_file_get(nf);

Note that nfsd_file_get() can still return NULL.


> +		nfsd_file_slab_free(&new->nf_rcu);

Why is the slab_free call now inside the RCU critical section?
Granted this should be a rare case, but this adds unnecessary
latency while the read lock is held.


> +	}
> +	rcu_read_unlock();

Is there a problem replacing rhashtable_lookup_get_insert_key()
with rhashtable_lookup_insert_key() and just retrying the normal
lookup if insertion returns EEXIST? That way, an nfsd_file_get()
is necessary only at the rhashtable_lookup() call site above.


> 	if (!nf) {
> 		nf =3D new;

@new was just released above, so won't this set @nf to point
to freed memory in some cases?


> 		goto open_file;
> 	}
> 	if (IS_ERR(nf))
> 		goto insert_err;
> -	nf =3D nfsd_file_get(nf);
> -	if (nf =3D=3D NULL) {
> -		nf =3D new;
> -		goto open_file;
> -	}
> -	nfsd_file_slab_free(&new->nf_rcu);
>=20
> wait_for_construction:
> 	wait_on_bit(&nf->nf_flags, NFSD_FILE_PENDING, TASK_UNINTERRUPTIBLE);
> --=20
> 2.37.3


--
Chuck Lever



