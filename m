Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805405FDE0C
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Oct 2022 18:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiJMQPk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Oct 2022 12:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJMQPh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Oct 2022 12:15:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C1A6AEBD
        for <linux-nfs@vger.kernel.org>; Thu, 13 Oct 2022 09:15:33 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29DGDFL0024297;
        Thu, 13 Oct 2022 16:15:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=A1Iyqb/fVbzE8BlZjearo5hgEzeOEBa0RqG2MXHJbEQ=;
 b=3F/1gIUQ1waRhAKYMUJ9/M819SjNf9F5tnlgxPrscHAuMJc84yLQ4CX5k/UVQmQVGd1C
 KMQnLVNNIiZblz/Z7d8hl7Vp35hkWKomhaIzUPjiykAj43+DEPrdr3Bll8yrUqAhJI6s
 4shyECSUF/aIq51bTLfKKvksMzvV/rQsirzN2CI1x/nn+5hfhBL3LfnHm4UFoZh2VX8U
 3KUvuC+CWknJbdOP0HT6eTQbdl7Ht2nPsn0iGgHNBzLs1r/5NOlnGZsnnN9OxOByA7S/
 o1r5agwYhxmHOP2LatC29vGGpfjYLoaLzfunK1ynC/kp3vaPEKRFvP0NjTVVkMTm7Agx 9w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k31rtnr7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Oct 2022 16:15:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29DFlDQn034057;
        Thu, 13 Oct 2022 16:15:23 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn5y75g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Oct 2022 16:15:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLuRecm2uTmi81FwP6Ilf65LLUDTGM0welE4psoGqs9nAXZXqyq2kNoRCziB78mAEcIAW50pa9vaC7VJbKbZYq0RmE3/bY9EsN2w6xnn9GhrmH6XeRe2VwtomBqytvLwuYc5j77yuRhJNxIVRJ8lpTe1kbuff+tBGfsAdo6kTzLDIu7h7MQvieeyrRuxQpqGpNd4UBc9T7Ofs6mHWqW4bzRCGfdwADQBEO49QwRk9q6xmmkFw9qz0P/rBdZCV+l1ItaasTRiFXxOMm1jyzuwfQuN+MAgYrpPqThhhaCmwNQ6YNHLIFVrTo04LtFnIMyPeOGJM7NeLz/BnyDdK8AEwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1Iyqb/fVbzE8BlZjearo5hgEzeOEBa0RqG2MXHJbEQ=;
 b=Sabdpb9unwyAoK6lcWQ/TVSYoNcyPoSZp4nHvyA7YQvFBO5aelPj1xpRsdrokyrU21e1kZ8jxfr7/qBRsQw3P7n38utraCFH/jtVp6IRZ/mu9IQNsCwkZhqIApYwn43LYjhiW43cXAI0P/UxbD/YL2jj8PHu5S2r9yAYWiZVFujqW6fzPHMTB4OsWtyC1tZi+IpsMUquGf8XMNXBtdFHzMj89SY0kFp9/o0MymvznrNv5s9WqOmm6wjh+JGbJMdOCwiMTw7RwPc1bOwGx2IrxXS1L8eB1DqzIENIMHsRiTKDmV6pLBLgTD4KfhM1LccApjlQpG+EEjvkyhkO6CVG9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1Iyqb/fVbzE8BlZjearo5hgEzeOEBa0RqG2MXHJbEQ=;
 b=s39/FM2AsDeDIg0jj5JsckGEeG97CdQdkYL0KTaRbl2OJpRGip/klm3cgmmZ3a2y/HF+klTdRqBnOhkPoaW92Aa9fmJd2gYE4TKBt1FB9yh5/PEywZdXyAEdKJFyQn2AHgrgbWixgm97tVIuuLEq/HcDUM/jcXq93JKGNk0dEz0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6677.namprd10.prod.outlook.com (2603:10b6:303:22f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Thu, 13 Oct
 2022 16:15:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5709.022; Thu, 13 Oct 2022
 16:15:21 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: ensure we always call fh_verify_error tracepoint
Thread-Topic: [PATCH] nfsd: ensure we always call fh_verify_error tracepoint
Thread-Index: AQHY3mqFytLThGlQ20+5ABlFzwJE764MgSUA
Date:   Thu, 13 Oct 2022 16:15:21 +0000
Message-ID: <60075DF7-96ED-4636-8E02-4A322D9EB522@oracle.com>
References: <20221012184254.30539-1-jlayton@kernel.org>
In-Reply-To: <20221012184254.30539-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW4PR10MB6677:EE_
x-ms-office365-filtering-correlation-id: 115e9b65-f581-4695-d245-08daad3620a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DXMzBTHcWY1R9U69t3mdstkCmoYAM5wl3p/UsXMIAcGoIJaEXIX2iXo4Yt8LhHUTB2UXyX9t9EqGnpefG+39juzFmBT+aa+HZPDsYnI2uv/dETP2wcxcdNHNu0JOdQEKGhX5gSIvLVtqBpXZO3sxbU44HVebdhDYIafcsIjw8S0fxvJigVlqZp6eaOhLTmRNU+FDtehq4uDG+eBFbBZ0wiQl8b8wmWApF7DxvduCJzjOa4/3sFlN+E1XcsgSy1r60Di2SfopGVQESby83A+MBrH3vHUMmgxgSB7mhViNvDJxVZeq+5L9bLxa/8ac2oNUP2DVOiS9XikHmsIUXYvdJkweayj+2S5iJs20wZHpBwr4wyXBWYWK+/PbpOhr4NY1Wk77mH9CJpQTtw5QfiYyiC/Pbnp5LCBNqk2tDM75S6kyeISwuFsKF0UAJbxhN9HfavzPrPSm7xTYBt4AFy+yINEkKhiyulOs8ztw9bZ/Sw3diAnztyJoxkTpAsPIpPq2V6YG8xrP2k65eQJ65+TdaTPih5pLSuMT03OqdG+ud2ZzYmhevITYh9roz0n8l/ZDQrkkenam2O9Gu4u8j9t5+ch3hR+Nmt8vPw4Z+mM6Zb4/9wBjBO4jLwJOOPu8Wk1xPL5LvZgwzm63kSdPAIUaXUDU+EM+o26jvcdOqA1qI7odUWqn3tuWM79yyg2X7zUo28XLp/EP/x7bP++BN/FlcNz4mnPwStAjXI+AsXND4fz4owDsD6JZQph1vctcrBrluYZJhkr3nfMC4m0E3hEU2edqCBYu47bu+ayLnshf8Lc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(396003)(376002)(366004)(451199015)(83380400001)(41300700001)(4744005)(6916009)(86362001)(2616005)(6512007)(36756003)(33656002)(8936002)(38070700005)(38100700002)(122000001)(66556008)(64756008)(8676002)(66946007)(66476007)(4326008)(6506007)(2906002)(76116006)(316002)(53546011)(5660300002)(91956017)(66446008)(186003)(71200400001)(478600001)(26005)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/VYqGCy86F2zujCItGzE6Z4iuBVyyyq022r2FIxru56GxsHBkm2QSPsYx5Ge?=
 =?us-ascii?Q?XiltyUur2cMpOyO31asVhkuwSdGHCIJwDUT+gJrValpodn0YI+OnW//yMFsN?=
 =?us-ascii?Q?PrJ3PCO29KdoqscLblabv5MzF1TUuDrBXlMOk4N3uMvEJ+3+TaF2hotME40l?=
 =?us-ascii?Q?sIai1dUmlX3zLGxR/YawcGAz6jykYhj2o5fA4vjJjKs4gzeNGulzS+uEpwI1?=
 =?us-ascii?Q?pym4B3zqqepx3XrmzukmsseET1KoGDGvlKtfgw+043fmHnJpLFrKC5cIfZd2?=
 =?us-ascii?Q?PMD2yYAp2Er08QBS2T5hhooP4gBYbve49O4i3PnwK9lT43u8h9yM0Lk0HBUI?=
 =?us-ascii?Q?QMdumUskAYeXbW0ODwPhaxWAmIna/hlpI+emXYwi4w2rvnzFIW6NdCh+6wqM?=
 =?us-ascii?Q?yN2thKLqiBofAFWBU6Csa+L8K3kN0eaqUq94+wUiH5iDW20UA2L0PQNmRktt?=
 =?us-ascii?Q?eUjzv5LFpVUJCI37tqujiXAw0pUoezcLi07PdJ8PyTGittUTeHvR/Z3pfLeO?=
 =?us-ascii?Q?cCreeYm7op4bcXjd1AiFBs/r/oQl0SKgIqwb76ubcRIoaGi+3X1zA5PT4Zso?=
 =?us-ascii?Q?QvQfboWXWyb1s8+aDC/xnKtQHJ//8uEDZte4nHDYpsXRnkb+VGdvWHGSS8rN?=
 =?us-ascii?Q?UAQOjEnTKTY+sWaR4B31e5kbu07SPRMmEFzMNLD6Qv3udhglFTIvfC6GDhpx?=
 =?us-ascii?Q?FxFXYOSW1XUySBdL6NwFyfNN6W3yR+NQ9FL5Xg4D1Ez7mN69bHjqgXvGy/JH?=
 =?us-ascii?Q?RPt6LCcsCxf+o6pnHJOUhxTZTb0VdNsYOQ83EsGDDS2TEaxEnPNHcM1E24aw?=
 =?us-ascii?Q?wDQpcWymQpyKpEHZfCbCuRPa9pglXezyHQ4wI9kD+BnpKUayF/YeLuMYLA4R?=
 =?us-ascii?Q?86BA9yanYrLW3c24Xb5qWb+OHrg5VIIFjYwDv/iEwNgis7oV+gmBPr0E0VJp?=
 =?us-ascii?Q?9O7+gQvvO0RNKG0lRdPB4mkoDi8mbPSRcR+7Yax5PLDA+RaXPk0PAc21DvXA?=
 =?us-ascii?Q?BmoFJfu+Xa3fbfzPvNS3gOgV3iHRCiGI16SdUIXA9h+cuV0leLIUMnaaTm9I?=
 =?us-ascii?Q?Dak4ki8eUPU6OnEde8VaWu/73mul8txcN0TiZAXslpvWxKXwaVxy88zQWJnI?=
 =?us-ascii?Q?4ULeorsZaci0OQW6dpJktJRpzDrDuJT8Nb0Pz5dRiI6ddk98SpXOu9Pp6Mvj?=
 =?us-ascii?Q?Gxr26tzl5+nc8giy+NIJbY9ewWX9gjymqAYgNI9o35w87lwpMiqVijw0h3IG?=
 =?us-ascii?Q?EZrauCrxMd3sDfOhhagZyKqEMuDb9h4+X54n4/WNUQfxH6qhEmym4yhi48+T?=
 =?us-ascii?Q?YjdgERnkRhdt5qoP6jQl4WrO/vUa9fFd4PpLTxIrIsfxgfUBfCZzkygYWh+m?=
 =?us-ascii?Q?nTIz5a+yX/KABj7wuc8iRAF1mZOgAH8cPQrGma6l7jEvJdMhmUQDSfZK4SfR?=
 =?us-ascii?Q?/dmsJKcw+pxjEZBmymjdN7b6Y7UWtAVsRRi6gnt/piPub2KqOYikwShZtBU4?=
 =?us-ascii?Q?A5kuQ57uDgMzzH7tLafiFdekYL6MH8oWvIVH58/BVA3thGbP38qpmw7ymkyW?=
 =?us-ascii?Q?FgNCHK1bBR5N4pGZ3+uxlrj1rid76maDhfO2+1mtQQOYRiGBua3YLNEl1SPW?=
 =?us-ascii?Q?qQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1777A755416F3C42992B03FE8DC9F7E2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 115e9b65-f581-4695-d245-08daad3620a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2022 16:15:21.3520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +hvcSgqxtr8xep0QPTB6BpwdqNd5uZkWsjEBgkya0cud7SJNnkcL/4L760U2bOoIvnA8q7f216s4ZXc2MHJJXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6677
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-13_08,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210130094
X-Proofpoint-GUID: ZZBW7pa4WJ6vlmVMxFJKEUAlUJgzQdCa
X-Proofpoint-ORIG-GUID: ZZBW7pa4WJ6vlmVMxFJKEUAlUJgzQdCa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 12, 2022, at 2:42 PM, jlayton@kernel.org wrote:
>=20
> From: Jeff Layton <jlayton@kernel.org>
>=20
> This is a conditional tracepoint. Call it every time, not just when
> nfs_permission fails.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

I've applied this to nfsd's for-rc. Thanks!


> ---
> fs/nfsd/nfsfh.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 9c1f697ffc72..43bb34f1458e 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -392,8 +392,8 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp,=
 umode_t type, int access)
> skip_pseudoflavor_check:
> 	/* Finally, check access permissions. */
> 	error =3D nfsd_permission(rqstp, exp, dentry, access);
> -	trace_nfsd_fh_verify_err(rqstp, fhp, type, access, error);
> out:
> +	trace_nfsd_fh_verify_err(rqstp, fhp, type, access, error);
> 	if (error =3D=3D nfserr_stale)
> 		nfsd_stats_fh_stale_inc(exp);
> 	return error;
> --=20
> 2.37.3
>=20

--
Chuck Lever



