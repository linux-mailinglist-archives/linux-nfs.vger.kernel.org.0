Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0036380C87
	for <lists+linux-nfs@lfdr.de>; Fri, 14 May 2021 17:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhENPHV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 May 2021 11:07:21 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60456 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhENPHV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 May 2021 11:07:21 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14EF4Vao137678;
        Fri, 14 May 2021 15:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=E36d/dau8U1X5kyt2voyRCGuXyX8s4EIDSDCu2bBmmk=;
 b=fs87XM0ei6JP/BiV2OQdR3IvVuYDib3Qq/HclZvs+vYonQSz/OMn7i/BVlQEPVk+JuGu
 bblu4wlEb4AfxMo+gKXxp0xH4gf9Oda/XenJZeNoPT3yvDXhQmh3rTbc0L4s0nvP1ASh
 yIpf2OOvBgoLBZNcSdCBlMQ5Iewbm6lXMRvHrSPGwe7LULkv/D8wj1r0v5NrzPV75Tdf
 NEVrND4gubKXYDcJ69u7BfII10g/torGlFKELOcAuNEAF9G/P/hy+/7D8ZcH74h/swpt
 D+jeLep+4eGaOWEadhKxcJhiYrdI1ZepoGG8/WLdmIdrNLp1KlycSPHMoC4r0xWDxQFq /g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 38gpnxvkb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 15:06:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14EF5oO6021628;
        Fri, 14 May 2021 15:06:02 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        by userp3030.oracle.com with ESMTP id 38gpq36bpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 15:06:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUv21n4rafx3Abnj+phVIwvt3SAb70CpyqWXHbglB3WrDjXbbEgyryfn/EZcaPI7YV08q+L1SX/6at3l972Jn2eT9QGjViu35JS1Hf4fN8VMaQLs0wJPbCV+5u0GreyJJysdaPaq6j+3fKL2FwAa0Q1m0BQcSxAseUvtDL47qS/Z0cR0IA6w771cxwGSzym7EQ44WYYwmCXRJmv/dUn7kANAtvdUN31QueOC2mToKoIP2zImS88azv7NzO+NIijtSJX3dMSMeifhq7dpdMxCzRkULZfGUKzvj39oBD/cZAiUxN98s3Kkd55Hg2AkfdjpryIBn8Jwv/PIvIMs2cKpoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E36d/dau8U1X5kyt2voyRCGuXyX8s4EIDSDCu2bBmmk=;
 b=A+Sg1enkJAoi6VWUfZ+kgto5h3gxbs4K37QK1n2O6Ac4xJKYHsweCx3Z+w9xXvgv0o127oc5GxgD2VBxV3uAkhkKknJXVeK+CiQQsVZO5auDJyls+8wDqdlGQL1OcIvc/A7D6xTUibLOIHcgZ0EeXC7N3a3zGU8MEzDQIujcF0BkNfIICCQWlAM4rvPGALuPkRx9AmBIuVs5Cu9wjEooiY5atVNjtueAXWJQKzfOBX4MxjjGHsV5ZyOaV8Ew1pGHafPN85oOEVcfmq1UQ0s8oPDke83gaCg1at5xeBH1DijGdo2Itcurte91k9F2rUMrcCmACqA4E7yafU2+jLLMgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E36d/dau8U1X5kyt2voyRCGuXyX8s4EIDSDCu2bBmmk=;
 b=wRwe+6xcThdBcZDMdIFv57u6x0vp571f8xSTy+ZsGnhZzFhel9TW8bAcSXXGTOs2s4+aiRcIiiXKL0IBqDQAj0qW1LinY+jPeklaGMlyhqJ6DlY5kkMh1Wrii+c+ey6f+fLWokw1SoLy1Jc7DC6v7RvV7bevJnjmFnyNccbfcHQ=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3511.namprd10.prod.outlook.com (2603:10b6:a03:129::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Fri, 14 May
 2021 15:06:01 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2d8b:b7de:e1ce:dcb1]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2d8b:b7de:e1ce:dcb1%3]) with mapi id 15.20.4129.028; Fri, 14 May 2021
 15:06:01 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dave Wysochanski <dwysocha@redhat.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] nfsd4: Expose the callback address and state of each
 NFS4 client
Thread-Topic: [PATCH 1/1] nfsd4: Expose the callback address and state of each
 NFS4 client
Thread-Index: AQHXSMVc8Rw3yD8Jf0OB3RUlJFuh4KrjE8EA
Date:   Fri, 14 May 2021 15:06:00 +0000
Message-ID: <161942E6-C5AD-47AC-BDFE-34C428349E98@oracle.com>
References: <1620999041-9341-1-git-send-email-dwysocha@redhat.com>
 <1620999041-9341-2-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1620999041-9341-2-git-send-email-dwysocha@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0156db48-6437-4294-dad1-08d916e9c963
x-ms-traffictypediagnostic: BYAPR10MB3511:
x-microsoft-antispam-prvs: <BYAPR10MB35119BABF4DBB8AD7FC47B9C93509@BYAPR10MB3511.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:514;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f83RB22EUSAReirjmvQKqSCJZI+x5mY/j+dpCgOZKinUqkaIp9zbERfd9JmPw3PPFsFTMrXIXWVlsXme7oveIF84rxLnLkTcOgOxiWpwloFwEzwHzuNE1RbEidB1mmvig0VbdW2fmgHdU72H63FZ629N94WZ23p5x/C5u/EiwHmKu8OBqt3UqwSkNLJI/9vJ3WVQqzUAJzpTg6XxMlkjRKVK9WeemfwECWYXReWiwHk98iZeq+dqfvZJv3x7CEIDHuhr32EZTR+ee9b1dELp7xPIyy+aorGr1L+kN8KFl5xChnaFRh5hBR4Rxn+aA4oYtEKGqDKiLogshl/mInURrpBnuLDoCkGZbn2x8SrsncK5zhaejLY80RNKN+tFSeTM6eCOFI2lCzc6zsT+nDcXPwrnOfxsPdbOFu7xcrrnfyFTC/EestsvLNzCibindQ4ifHq9Xm7kWEe5liqK8uPP+Ug1d79K9tSBpnd/RfN8JWCFOC+DtHl169XCcq8/unKLzcu/oBt4CfIYc+iUHpJ0afwvuU92BqRUuGltWh8zrKCJnS/eHTyOJh9ZsN2Y83EErVYewxV0RVyez5iJAywVqkFeAzSk9I/2nH6rWLFo4ZDnBVnH/iQa+dp+m+KrqkDHzm3jzmR7YanNbar2JMLnt/yhKm+szvKgxMJEXiIvv2E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(396003)(346002)(376002)(478600001)(2616005)(186003)(8676002)(71200400001)(6512007)(36756003)(33656002)(86362001)(66946007)(64756008)(76116006)(91956017)(8936002)(5660300002)(66446008)(6486002)(2906002)(6506007)(316002)(53546011)(54906003)(66476007)(66556008)(26005)(6916009)(38100700002)(4326008)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?e2yCV22/GXUrw6qw3eMcRjzEWVNO0Xjft0mRI7Y4O9lqb6pZnZsI+uhHJ6E0?=
 =?us-ascii?Q?Ra7qefWboVRLV9f8NkrSqEDVMk1za56q6bitzeK2VpTKhZ3xwvBxjiY1NAYd?=
 =?us-ascii?Q?9KfpRqYHcn0C43rE1P/VbFjVrgrm3SlsJt39Czl57TVTRCxrB7Cr7k5bg8pF?=
 =?us-ascii?Q?PsTYCWWk5SKI3ZsSsD8blEsLX6Kbdjo5f7x5Dte6Ev7CVXSwjGtQtqg4lqfS?=
 =?us-ascii?Q?D975F7z1GWtKm8l9BXJ5eTVgnReyPBptj5smHbOf2rMnLJMuYDtYLJsS95fp?=
 =?us-ascii?Q?MZFqHGdkRTVHrVG8O9F34Q/jwSXaRcvC3+k48TEsMJWDqt2qSTAHJa6MVrMX?=
 =?us-ascii?Q?5y3Sszs5t7YfO2yqvMUdqDVu84yG0lLBTa/DFDN8+vcwlQRrJ1H+XA01PsjJ?=
 =?us-ascii?Q?sF5773nIR/Jh6n7nShlZCeZIHkERayYw0cy8qmIIyEYa2gXIt73HXdVTFxOs?=
 =?us-ascii?Q?RH3FfIjAHAZNRAO2Yny0WpqCYzPVV8oigP2s0wkSPp8trGdPHLSDVC5keJtB?=
 =?us-ascii?Q?/hicQh61bT1ZilzUIQXH6bUan6lD8YswFQtFg5a5+yepJUcOVU+ljBEHs/on?=
 =?us-ascii?Q?Qr+MyKJyP0GeoIGuZCii7rRltRCuGYqzdmjS/VLCXF1mZYyi9mFFHvWJpD30?=
 =?us-ascii?Q?ty71jx59QOshwh1vEHo+9765zVX9Imm7DJ1ffsBImlUbTPoYHFDBFX7oB/r7?=
 =?us-ascii?Q?+4odZjVzpm2iijSERv8AS87JEEc5XTZoaMVa1uVrMch1g030hJ9++huN+q8t?=
 =?us-ascii?Q?+I7XwsixKU75J61opUgrwcGIqaHb8m2HeUszps1hEL+78yly5AYvKJUruEhl?=
 =?us-ascii?Q?W7hVLpWihnhqdUNbry24rMtfd17XbA/agQvBgh6ybODjK907/lP36zbahfJ2?=
 =?us-ascii?Q?2b2DxzNPyNeFfM8WyUEOeouRGKqL0yKoT5W7uQsfvwkAt96dupC3t/265TlM?=
 =?us-ascii?Q?q9K62t84EsUbG67+Rh1p24wCHYm6/pkaaUhgzCy7WlzWxzZRv82J6gvRRsVX?=
 =?us-ascii?Q?SVR/PzpKY2KTr9nC9iol7OLbVunxtnx3Cq7S3WRFb8d9pIEkaqS5DyTofM0z?=
 =?us-ascii?Q?aAShtVnQUM/fdPPDrI9+PWeU0VZWF+KMSWS+ycAuxcUT4GN+HFW/fuVkwGNs?=
 =?us-ascii?Q?MdcZvwOxU5Yk23iwwdbfBF03n4ORUfLiLz7qzmm58ndTACV3b6c2JVzkDlI3?=
 =?us-ascii?Q?45d7R83no2AfvghwlvObiGCJEUqvq8/x0p+jpV17XaGdETfoXvAZGPFuOy7/?=
 =?us-ascii?Q?OaJUKN5RIkNCF3WqIDCov1L150ZV9adi8PfmxMQMT+cfJOulQMfXRzP6IpL+?=
 =?us-ascii?Q?pZdw2psEsrodUV9JcMScjD4+?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2582A58C134492438FB428F413A9E866@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0156db48-6437-4294-dad1-08d916e9c963
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 15:06:01.0127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3upwRfvz/8WMo39ttN8zgoGE8bJGnXb9wRnEP0/AqmCAgIFanTqck3b7K9k8ajFiaiwAbJ1CAWPGW03bimFoaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3511
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9984 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105140121
X-Proofpoint-GUID: T3RxkYS5Y92-uIC6m4L5lY4dx2-dqVJs
X-Proofpoint-ORIG-GUID: T3RxkYS5Y92-uIC6m4L5lY4dx2-dqVJs
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9984 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105140121
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Howdy Dave-

> On May 14, 2021, at 9:30 AM, Dave Wysochanski <dwysocha@redhat.com> wrote=
:
>=20
> In addition to the client's address, display the callback channel
> state and address in the 'info' file.
>=20
> Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> ---
> fs/nfsd/nfs4state.c | 17 +++++++++++++++++
> 1 file changed, 17 insertions(+)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 49c052243b5c..89a7cada334d 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2357,6 +2357,21 @@ static void seq_quote_mem(struct seq_file *m, char=
 *data, int len)
> 	seq_printf(m, "\"");
> }
>=20
> +static const char *cb_state_str(int state)
> +{
> +	switch (state) {
> +		case NFSD4_CB_UP:
> +			return "UP";
> +		case NFSD4_CB_UNKNOWN:
> +			return "UNKNOWN";
> +		case NFSD4_CB_DOWN:
> +			return "DOWN";
> +		case NFSD4_CB_FAULT:
> +			return "FAULT";

No objection to the addition of this information. Style nit:
the "case" and "switch" lines should have the same amount of
indentation.


> +	}
> +	return "UNDEFINED";
> +}
> +
> static int client_info_show(struct seq_file *m, void *v)
> {
> 	struct inode *inode =3D m->private;
> @@ -2385,6 +2400,8 @@ static int client_info_show(struct seq_file *m, voi=
d *v)
> 		seq_printf(m, "\nImplementation time: [%lld, %ld]\n",
> 			clp->cl_nii_time.tv_sec, clp->cl_nii_time.tv_nsec);
> 	}
> +	seq_printf(m, "callback state: %s\n", cb_state_str(clp->cl_cb_state));
> +	seq_printf(m, "callback address: %pISpc\n", &clp->cl_cb_conn.cb_addr);
> 	drop_client(clp);
>=20
> 	return 0;
> --=20
> 1.8.3.1
>=20

--
Chuck Lever



