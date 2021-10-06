Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD51423FFB
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Oct 2021 16:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238875AbhJFOYZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Oct 2021 10:24:25 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:2486 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231356AbhJFOYX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Oct 2021 10:24:23 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 196DUcXi024877;
        Wed, 6 Oct 2021 14:22:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rLnvOYUmP1tUsBxGM/zbvf6W4F8PUC01bol3wyVOBio=;
 b=lmYQ2EIZyHIyIj/GlXuR1ZXqb2fzJ50d1tkfeSv1Hc3GwaZz2PQMMIBcq+EIsY8AIPcN
 yFL366sfMN54hXl851+NuOJviHMW3PCvhiyaO6WgaPdw2CwWqzaTf3pc4YkEkzrDToc0
 uJKwl/gxoKE6E4LtQZZgx9GBa/nYJbIRG1RnosOk910Gx4Xf0LZRAx5u/ziuO6ehv4LB
 b9ZaOpvRGV7F6YK5n+hKDfMVH8/D6OSQpY9IjidBdrqn+tWGq6QHs8oEraF38zJYMYQb
 yIlb2/rQVCVag2ANubYO5Gk8nUwtEPJJGSxtjCJ3x2v7mlcA7tx3iap4FIujXfDZ/8qx 2w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bh10gcv2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Oct 2021 14:22:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 196EGNfs126909;
        Wed, 6 Oct 2021 14:22:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by aserp3020.oracle.com with ESMTP id 3bev8yf55p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Oct 2021 14:22:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmdIxc4IZ89N05+CnJmUZfRwIiti2b5nULFSLKT94vp83BVpZZ2oeNPh5o9Dr8USnlKBSrxsuvDF6gY7/NEvqxn9Si0rX+OXG7iEpnRmd07RDiRxSttNr38O/vPMj5GyrkKgVeHLvKEgjKVDiHhqlDYiS0OBSzCG9vK7Y0SooVzO0PZ3s2CT+LLL1Klz3noJcLHZTCHtkrn9uVvuogfNsKW1SaKUrqI9GnikcrYnoVKxTQdgOquHskZtKoUdxU3mHExW7PX+NdUGhX7JQwiQUtvEsw98SRbPC5WelkLe0qkpDOWFXWyNFveTmkdeT8uKLnb7Bo8uv2cbuZc0HXzDJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLnvOYUmP1tUsBxGM/zbvf6W4F8PUC01bol3wyVOBio=;
 b=EH5K7GmAmtxL3CWBfUMvYFO/EOq+0eChkTaBlbOGUGik3nK130eM1OREmEK608mH06I76qOkmNVuzDQJNBc125YoxWdU7qAqnMy8Gb0yAGX2N3+iPeynJVOI7J+aZ9p60LSZbxiQe0lPAxSPHz61pnRPZdzAc+lc4gw3s5SzOCRnOjnt0n3F7tP3NfSxjBldh72MDZnLxOwCdDAGfOa/Lv90chHAafVOFFQiPRFBhzK6/jlXLLZX+BrerITbz3OdfWfuOFL88kSZuaeX+bewCbVD5YDBdJuO6+Kl2e7x5QH7WXLGKiw6QfgiEox84fr8xYgahrtTRnZ5w1dZ16dNTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLnvOYUmP1tUsBxGM/zbvf6W4F8PUC01bol3wyVOBio=;
 b=m4aXY/2Vuvf0qqR/SmJ4va/n/7fLtJZ7LeftOzKUwwS+iEHVap91SrvZv3q5BsXeF54EZF+wbMKhxWiquc4YZXgYh7kwKFGVgjsVLvVUz5539L/2faOrkYAedIEFoMcQYmVZ8Noe/Q/AjdmXJxWxILTV5h+MDZMWxF9Lmcwo5yE=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4624.namprd10.prod.outlook.com (2603:10b6:a03:2de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Wed, 6 Oct
 2021 14:22:21 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4566.022; Wed, 6 Oct 2021
 14:22:21 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>
Subject: Re: [PATCH] NFSD: Keep existing listners on portlist error
Thread-Topic: [PATCH] NFSD: Keep existing listners on portlist error
Thread-Index: AQHXur0BoBZXTWQOvUety6Va3DckV6vGBaoA
Date:   Wed, 6 Oct 2021 14:22:21 +0000
Message-ID: <4D02F6E6-3BA3-4000-9254-FFD565946F99@oracle.com>
References: <45b916f1aa3fb7c059a574f61188a8f2f615410e.1633529847.git.bcodding@redhat.com>
In-Reply-To: <45b916f1aa3fb7c059a574f61188a8f2f615410e.1633529847.git.bcodding@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0218769f-d4ed-4354-3d57-08d988d4b61b
x-ms-traffictypediagnostic: SJ0PR10MB4624:
x-microsoft-antispam-prvs: <SJ0PR10MB462431D3396C81300C27121793B09@SJ0PR10MB4624.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2xmbSCiOPUnlNh2dR1i5aeH5hOkLLhwYjTB6MPmKaID/tq3fIncTZqNIYmlWqcV3FFPPRnST5lJyxSetsWHxlFM9BsIqT+7Gb59VSWCVMUvhU3fjlY+R2dax3RS8YZ+5K/du+cs9R1HJYVeBgARTSynQdtVPnfyTokD4TaZvXbWx3cKDL88igL7DfulK8YEbdfpwaLdyQwp/lA3FF6xD1uVjIwGh0qlYCImZkMhwhHaNshH5OrNHm/GtXwbl9IqKwFfdwAQRJGb6cIPlh9LKBaY5ZPMakY3tvzK2DT8xZOc8gOFt5vQMNaCuVaFAVvDmBUON3fhB6KQGP5H2aVgSRukkHCBzpEhQ44cyihIblESc847HeuHMYaabR3c0zpJsPZ8t6u7GuVHYiM+Ve+ywMmsp9fRIjGQYJ9eaEfJj/TiFxqsu0dM3b6cWB5iwY6IQvKV9TaLvBgVRIKj8A9ZwhggOITF6GeHS4Sde2hZOykRQmhp2D+70auB2CMd3Mx80dyC+ImCKlyMiCO+3trGG17l3x38YvBv8jbF44PlJD3/eczEGxxEP/08I3+vUTXvGpz/LJQOHyWISMT94MeXmqkIttoQKv8nTzQb7eheUkfELNjpX3M9+w4DTIiNz7uduewwfaUcN5XGWFos87l7BrDufUviAZYFJ+bQ/KstugZuY0yxWS0oQa34JNS4YYQbMmhuM5h7kIG15W8KEcQvtjJDj3FSzgESsk53sWYvyW9ppS9wcdNEByeOEeazZoOCm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(64756008)(6506007)(66556008)(508600001)(66446008)(66476007)(2906002)(54906003)(76116006)(316002)(71200400001)(91956017)(6916009)(66946007)(53546011)(4326008)(38070700005)(6512007)(6486002)(26005)(5660300002)(186003)(33656002)(2616005)(83380400001)(86362001)(8676002)(36756003)(122000001)(8936002)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Tv+WhUA3iwISFs04dX3qVK6HBtQdf+Canv3qk9M9LiVFKoQPeQJ97EG8bVDv?=
 =?us-ascii?Q?bWcCI6q2Z3oW8NVbPYf6LU6Jxz/6CFD169VoR6w/9T4eCajxVSinVZ/vOmFx?=
 =?us-ascii?Q?K5wTOyKDplYcdVbmX0+M57OOaP0oZFgeUMkZkKCpGDEOjRZwE0HfzjYkm3V4?=
 =?us-ascii?Q?zsBeX6SBU50aU/KoXgWyvEY6Jg48yRL08kNeXaXb8ipn/++QbyDrcxpfuWd7?=
 =?us-ascii?Q?3XFUKIcBTCHQt1os60AJUWcqbfo5E+0/1PKrBJ2w2zgVySpUcdGFH5qywJTv?=
 =?us-ascii?Q?OC2kq4wr9mGXbRjlji9gdGfvrfGwChYQQtGiueTwpGLBZBvj9T3gOzw/rn9j?=
 =?us-ascii?Q?6zw1yV8+lWwRl9h6C/JtmQV7sEAICSb1CMMxKf4WbBwZIyTSbA/4XVDK3hIs?=
 =?us-ascii?Q?N7LPhEbTgPSU7MYPVqutdUIgbYiyr5GkEVYYx3fIP/GEb0xhjfD9NrmmrQVF?=
 =?us-ascii?Q?7LXm6fkKTO6i7/2XNrFuhcwwQr+lZ5OsLmWnfxWlbEfUAG2yiWm5YFViyI3o?=
 =?us-ascii?Q?6AnvwAvn9GcD3FOV8wl0m6h/fo1CczLMsvJdDRyHAzKr1rZZlyHzMRNqx0kM?=
 =?us-ascii?Q?zThVIf2PzxKtDXy5IHWXmZNmoBXwnR+RKTwq9bbAbFT7rU3f+ZUSJJHdFpyi?=
 =?us-ascii?Q?OLVmNQHAT/a7iFBwkKnRHljmmbq+hgC4u/cxETBKUrH1GRd7im0B79JEh9HX?=
 =?us-ascii?Q?6jZwPsiuSkQ7/qRV1+G8fqPgMrigz4GBLTqQkF2Gopl9QDJRiU15s7A4ch+P?=
 =?us-ascii?Q?DeO1b+WeTbBcZOhZndt6csPAZ3y52GLFs01NoaYKv8bNeZH4A8kgvL6ixM+Y?=
 =?us-ascii?Q?lJQdKtfAdDZRzAyPLS0pHgjwiptq5hvvVAt4r33l/2bqZlvIM694kdlnzP21?=
 =?us-ascii?Q?ArW2gR1UAFvRv58rlsnsWYba4Wk6sgv2yAuEQg5BxiwZu3o9mologjF9FTFe?=
 =?us-ascii?Q?id9Jz9y+xL/jFYv4SgJEJxm9XldKQH/oOMJcp+/nQltjtdGd80/C2QU7kziy?=
 =?us-ascii?Q?TtPmFq9NcdTXSyxVIyaLr3hzRhMZGPTox3Uh1Xa4uY6m9drE/h6QCkS6oVp2?=
 =?us-ascii?Q?vLFyJNuRCWXZLYnGCUIrWcY0XJ8ryKPO9sdrmRIWQsAQkHvGF9HHVqgo9dFD?=
 =?us-ascii?Q?28Hoi8MoElBdYTO/xnjnecAjkRMsn4C3xswwmJz3CziBDV/5p3K9pNen3KPy?=
 =?us-ascii?Q?bNztaOrnTal8TGegs6BotjOOQsFa22v+Ta0fKHZPo87U8lbYHaOE9IDOUiso?=
 =?us-ascii?Q?iA8bTi2hVCeSMdZQG7nB6z76ZNwyNL8L2eZlxwgmtUSG4K9eSgDLJYrIMAiW?=
 =?us-ascii?Q?1YFpm49jFzIOVmqc3KSFSU/V?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <079B9918B1AF3C4FA1646D634276D47F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0218769f-d4ed-4354-3d57-08d988d4b61b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2021 14:22:21.8452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pEjThKMSehfifb8RCYM6t6CFpy2Mylou66ian7VJdXqZPWZYtlXUbpsA/p5dszG0AeJmPiZOOF7NugeooBsCEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4624
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10128 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110060090
X-Proofpoint-GUID: ryqLsc_X3AH1NcGxF2Z_AtGT79VN7WJj
X-Proofpoint-ORIG-GUID: ryqLsc_X3AH1NcGxF2Z_AtGT79VN7WJj
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Bruce, if this looks OK to you I can push it via 5.15-rc


> On Oct 6, 2021, at 10:18 AM, Benjamin Coddington <bcodding@redhat.com> wr=
ote:
>=20
> If nfsd has existing listening sockets without any processes, then an err=
or
> returned from svc_create_xprt() for an additional transport will remove
> those existing listeners.  We're seeing this in practice when userspace
> attempts to create rpcrdma transports without having the rpcrdma modules
> present before creating nfsd kernel processes.  Fix this by checking for
> existing sockets before callingn nfsd_destroy().
>=20
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
> fs/nfsd/nfsctl.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index c2c3d9077dc5..df4613a4924c 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -793,7 +793,10 @@ static ssize_t __write_ports_addxprt(char *buf, stru=
ct net *net, const struct cr
> 		svc_xprt_put(xprt);
> 	}
> out_err:
> -	nfsd_destroy(net);
> +	if (list_empty(&nn->nfsd_serv->sv_permsocks))
> +		nfsd_destroy(net);
> +	else
> +		nn->nfsd_serv->sv_nrthreads--;
> 	return err;
> }
>=20
> --=20
> 2.30.2
>=20

--
Chuck Lever



