Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCEB5F1446
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Sep 2022 22:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiI3U7v (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Sep 2022 16:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiI3U7t (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 30 Sep 2022 16:59:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D4213E1D
        for <linux-nfs@vger.kernel.org>; Fri, 30 Sep 2022 13:59:47 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28UKnSVh021207;
        Fri, 30 Sep 2022 20:59:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=S2guXIw1WiJvjvyxvBD5uv1H6pIBtHx1zZaX+ygmGPg=;
 b=DBkbge0Xe13uRIftW6r2oXnXlW6i6jJUyjW34PmEeZa34UVl39zk7b64MkRFpgm8+kdX
 fu72Iumov+GpJ/cO7aEr/gUaivq2ZcuszkkxC+x2K+exX0wbRxvBZ/dyox0ttu8FVhlT
 qKxfjXokxSYX9E3ppk43quvLLbyBb9zXstfDf1wm8cRp9VTz0csJu4nZq/gdxGs7ur7K
 AJDQLnOp/0PydD9QEd6/vPXDVFeVC5Mx45253GPHIa0Zg8tWKbDEh16sqNmI7Rk0P1zA
 fyfALl15EEUr3obkYrliAhGN5bQPd5b/kP8koFNQ656hRCDuiNYrKwJTPAxuwxBspw2e NQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jsstq048s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Sep 2022 20:59:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28UJo5IH004919;
        Fri, 30 Sep 2022 20:59:42 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jtps9cru4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Sep 2022 20:59:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XD9/dO5lu604MFkx7vZvYuR9lWIrveI/JLgXTZ5G0fa6ahfeSAoRdNdoAxLrIBmvfoWJypm6uttuMVS8QJmyrYJOOES5LGi0ZGU6dW/suD64BpL8GnEUdxqgxCQf7K4rJvZtq7lSRcLStjxvEhTcME89ferwNARxvBBXEQTUAAEJzPmEo45htdIRDFbqTjnRF/xsa77dL0Tk/2NnRgNVc9LChM4XMX45R9Iaz0zuf8trJyuvjFKLEjRQwDTb+TeEE9fRZ+3sHIQ3Vfj+STtPPuz5jFIDXu94mgBaF2NfFlHg18XBisDUcnPKkcJN9G9HnAIBQgifCsfBhtGqba3k0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2guXIw1WiJvjvyxvBD5uv1H6pIBtHx1zZaX+ygmGPg=;
 b=d8qdpsNILMjXK1k6fTWoEpVH/v3frrFNiLRRllO+zLaDABJR0O90pP12NqFb/9s+ARdr1WIiBfiKkHdEkm4fSPwFuWEb/rXVRQiTMoDA//0q/erIngh1tJJXZPGD4/DN5KFQQlRygNO/OA77+//qjnmdtqNatGE9VKKfvFGgF/UZTPU1uN8/9JG4GB5ttjGiIVOjkBTbjWtsKv7aejbRkXjMaOlWMknJfA5KE2CbzpcXLI7rP3KxUtMTFSgnXuJ74UIu15GJRJ9bg+OOgzA2gLT2aSSJboKlM6dZ5WFdJ+Bq1Jg1CXPV+BoNHOv9V+KWOc1gBPsG4UuNIhUnLVgfbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2guXIw1WiJvjvyxvBD5uv1H6pIBtHx1zZaX+ygmGPg=;
 b=R+8PMh0ZFko1ZqjWIOgk8YBaNLrofPEaYU+XVoV/Wssb3vBvRVMX13Pg2UuAmhXR4+o3gWugrrERj5bbg6dNeLM96z8x70fR2/N2lYteuwBko921/+gXem1lSrcmmsrz6XzpLq5rBmDG/K4ctbIRlEtnAO88+zhg9bBSrP8hXZI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4817.namprd10.prod.outlook.com (2603:10b6:208:321::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 20:59:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5676.020; Fri, 30 Sep 2022
 20:59:40 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/3] nfsd: fix potential race in nfsd_file_close
Thread-Topic: [PATCH 2/3] nfsd: fix potential race in nfsd_file_close
Thread-Index: AQHY1QEVVjBDwZrkT0mQUKwwKynMra34dMkAgAAAUIA=
Date:   Fri, 30 Sep 2022 20:59:40 +0000
Message-ID: <14F4F92E-427E-4D71-B57B-43C01422F1B1@oracle.com>
References: <20220930191550.172087-1-jlayton@kernel.org>
 <20220930191550.172087-3-jlayton@kernel.org>
 <225eb68c838607125ba82e605b7e02b7100d4cf6.camel@kernel.org>
In-Reply-To: <225eb68c838607125ba82e605b7e02b7100d4cf6.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB4817:EE_
x-ms-office365-filtering-correlation-id: 4dcea253-69da-486e-cdd3-08daa326b157
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V+GUeHZv7JO7gUUj3z6hjWcsUHbnFrGnCHqbY2dwjiGgJstdoFJ8uNeNy+bXQv0A+ozgg7jht/6r7TqYAD4ACiRFo1iImW97FS/xAD66LapO1FvxFNhahxovkOUazhDw71Q2IgCLEZAjhzbx1XuIk+54otbqB2n8y7YQQ0XDgbcP2Jc+2C0karyAgmr2RM4mX1auz0uKLK6yMsz5ZatBejANeuAj3wZFb8WVKJm2nc7QUvW7fJzT0bcNY72rE/7JZJwerZtrExGKZywvV34Q7NksSuLBe+7tqPxnXNmECNuHCQ6CIVWMo5+msKy6BAwMIdgP1mBqdE4CpQvMkakyVzns1EvRlWLAYmA3DZA0vXWUxV2hm+7mBkKnkoyL1kZD3uoFe5lpRHA3phppKjHqw1ha7Ggr0vuhOIc8fn7d2eIyl2NzFjA+CBXgbZXEcMRbEi8hDfJbcMN/yzorDwH0Hsq6+OJPZL4gpxxPK1fh2PoK646B28n2w5sk/Hb29PQmxJKc8yhHitXdVQncpHNDer6vRvV0I3HS4enExOgTRf0onA+Klo6Uw9a4cs9Wqy7IxeqIxIrroza82d6opQJP07q2880EeAyBEqgdPdCIdJ89VxZUt8zHf0cJXbVOR2WFPbkD89t7kLp3T1psUMlONg1/NQdmCiXmwXLKKqk/8u4FBiJJYtyEYA2YGjxq6sWBcbm0aMwEJVGauPRHGS5QpRpWrbXcI+kvtZlRfZkSLE8Spmazpt9IO6a1BMibPI6wBuv3HKzN9DJvbwwb7DOtUWHkbK0u2ZnsEIBNKxfUmLE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199015)(86362001)(53546011)(66556008)(6486002)(38070700005)(66476007)(76116006)(316002)(91956017)(64756008)(66446008)(66946007)(122000001)(6506007)(38100700002)(36756003)(33656002)(2616005)(83380400001)(478600001)(6512007)(26005)(186003)(71200400001)(6916009)(2906002)(8936002)(5660300002)(8676002)(4326008)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ml4WaN6QVu4+QCwECk1k4/S4K1DM4LFYalNtxfs3cbCGdowyaSiudGp3fAIB?=
 =?us-ascii?Q?/wAStFV5Guc9qs9ajUc0BS3UhsIC9oDvW9rEDK3tiPomm7EgTXj1qImFxH46?=
 =?us-ascii?Q?xY77QNTqIWYckQ2BDpezTSkaUIcSCwUJb+FmmXj2VHtN94BEdhh32AU3Q+Lx?=
 =?us-ascii?Q?JHAAo6qeTb3fxC5FFGIWb6fdJEFlGLNDr4ByLRBH7EL6UaWnRVCnBtSNl3jn?=
 =?us-ascii?Q?8GfQkUB68y59rMRAvQIlpiukqTRbDhGoRS3BLx8SlXR8/Lh8SwMcGc4iAPuw?=
 =?us-ascii?Q?elk+BkenTHPsW1XuHJZbhi5oTJJOJCqnplZnR9NEY1f0TBFDygMupK2nDjpZ?=
 =?us-ascii?Q?kCpVMLb6zg5iVC4uqYWOL10cGxTZVDOcJ0CsSv+57G9cbL5bKsGEMT183ZX6?=
 =?us-ascii?Q?avgE+IbfDWjVNjjhIah7/j3YCRxGOo9RjdrwT5HeAoCgc8TDBO3YFD1slCvf?=
 =?us-ascii?Q?4c9LofaLOKxENZazDyUL78xhxgM0Erg5kKnP1l37sy608Or0deXPu/qRHyj3?=
 =?us-ascii?Q?wnfcZD9EXOQrz3L530kgviv7Di0XJNwGAXiCGObpYzYY0WbaEYev9loBH1wh?=
 =?us-ascii?Q?4hOu4sho+FzArE4IXGAypBsKhHOlZ5/5VILiw/8vT4Ypl6f921NWVo3YIEAW?=
 =?us-ascii?Q?KGSsmyKyORVjofWpvPRuDZszVjYUPPMsMT9537kqI+ifLOtUV9/51vvmLjBu?=
 =?us-ascii?Q?av2zS8USaBHgBL77Xak7W/8BeJdWMEBl50fQ+GeIpjnTKIgi7bypIBcGWUJN?=
 =?us-ascii?Q?w/bKJ2BAUkTsXy4+WFqyG0fbzYb80/nz2cRspK73ogGuoN5+2qpevFdNCF4G?=
 =?us-ascii?Q?YT9hwGaTNlDkNobGxduTMsK02u4g4W+qVNBm5n0RkMNMPHeiCXqIRvnqlLSe?=
 =?us-ascii?Q?YqYygDMYORD1bVuVV1UV8xJnEBkgv2cn1LCdrxRMqMTwZORK638PGe/HrfmJ?=
 =?us-ascii?Q?rIHdgrXGDYJ151lVzlwQSC0kzNJ6POwxdhJlAd2780YKc3u3dgplEo0gFSct?=
 =?us-ascii?Q?09BgqZYscQOsSHnAJ5eyf8P5Jcrw2y3lgxXcHAk65o1z12IRhDlHtqvyRp4C?=
 =?us-ascii?Q?5zHcdZOBx9eNOcYr8L46wb35SybNJoXvP9JgNNgHXQ9f9ttJdYOIeTIYOkw1?=
 =?us-ascii?Q?pIbfdaMvUD7WX4LXqHoxaiXBSBSMrfeyX9/+6Eyh164JCHltNyxXr1Gz7wxh?=
 =?us-ascii?Q?eTaPn7LhT8AaKSldpwgkYMZKCcykCcRQ9uWy603L2XHN19+M7P6CrrKr/LOy?=
 =?us-ascii?Q?9wEOrNeppg4Riz0pCmjsPQFz4XnVRazZtv4Flcu78JTfL88Dr/psUF8JUINw?=
 =?us-ascii?Q?qW254YWPO4EJ5MUwv9FGxJY9WR+iR7TiDXrZxJDho9tsbYVVlVnyX35L5VTm?=
 =?us-ascii?Q?Osq226D6XTTTM0gsVU34s8jkMgKoRB5164VLYqkCx1cuud12UvTQnPDsvFDh?=
 =?us-ascii?Q?cfZo196EYq438RwJYigMNopMULNmPJ8YQuo2X0RepIyKChA00boJMktjNbEJ?=
 =?us-ascii?Q?L1Xrb+jqXX9/p9QNfYr71TsblyLPKoViAxmY6o6awHc74N74L33wL1i1X6k0?=
 =?us-ascii?Q?sLPZuuGOvqykOe/oTrwx7EZfuXGiDdiFVIAG/kQufwL+dIdaffVBjDCqjdKg?=
 =?us-ascii?Q?mA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <619466B741F06640BAFC1A46E9911AD4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dcea253-69da-486e-cdd3-08daa326b157
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 20:59:40.5440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AutqmSek1QMyQ8MZfIXHWDoCnZxup6tXDAtaKtbnpbUa8irmwYbxSBw/SKpkOQJdpWlRXlQZKB3QoZOxIKJ1xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4817
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-30_04,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209300131
X-Proofpoint-ORIG-GUID: TIcqMYTs_2RDVf08RiLSbx_MxX44P4ab
X-Proofpoint-GUID: TIcqMYTs_2RDVf08RiLSbx_MxX44P4ab
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 30, 2022, at 4:58 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Fri, 2022-09-30 at 15:15 -0400, Jeff Layton wrote:
>> Once we call nfsd_file_put, there is no guarantee that "nf" can still be
>> safely accessed. That may have been the last reference.
>>=20
>> Change the code to instead check for whether nf_ref is 2 and then unhash
>> it and put the reference if we're successful.
>>=20
>> We might occasionally race with another lookup and end up unhashing it
>> when it probably shouldn't have been, but that should hopefully be rare
>> and will just result in the competing lookup having to create a new
>> nfsd_file.
>>=20
>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> ---
>> fs/nfsd/filecache.c | 12 +++++++-----
>> 1 file changed, 7 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>> index 6237715bd23e..58f4d9267f4a 100644
>> --- a/fs/nfsd/filecache.c
>> +++ b/fs/nfsd/filecache.c
>> @@ -461,12 +461,14 @@ nfsd_file_put(struct nfsd_file *nf)
>>  */
>> void nfsd_file_close(struct nfsd_file *nf)
>> {
>> -	nfsd_file_put(nf);
>> -	if (refcount_dec_if_one(&nf->nf_ref)) {
>> -		nfsd_file_unhash(nf);
>> -		nfsd_file_lru_remove(nf);
>> -		nfsd_file_free(nf);
>> +	/* One for the reference being put, and one for the hash */
>> +	if (refcount_read(&nf->nf_ref) =3D=3D 2) {
>> +		if (nfsd_file_unhash(nf))
>> +			nfsd_file_put_noref(nf);
>> 	}
>> +	/* put the ref for the stateid */
>> +	nfsd_file_put(nf);
>> +
>=20
> Chuck if you're ok with this one, can you fix the stray newline above?

Sure.


>> }
>>=20
>> struct nfsd_file *
>=20
>=20
> Thanks,
> --=20
> Jeff Layton <jlayton@kernel.org>

--
Chuck Lever



