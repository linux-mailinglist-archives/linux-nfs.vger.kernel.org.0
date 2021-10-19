Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245AD433871
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Oct 2021 16:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhJSOfy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Oct 2021 10:35:54 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:34834 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229524AbhJSOfx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Oct 2021 10:35:53 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19JEF7jQ004735;
        Tue, 19 Oct 2021 14:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=G4O961XxPNtZeSnz2cO2IYP7kxlULfchL8aTc8dG3KA=;
 b=IsfJPTqu8GZOjRBAGlNCLaof/JI4OM4uTojIAv+HLwEAekDKe4IMh8Y8eiVQgHIytwG2
 fUQbUQ4YX/+EXFY1iYiypJnkR7AcFeWGy1l4wfR+qOo29nN81iNNiBBB3wDBPjXx7/2Y
 KYkTqLSAzFW7j9RSElZlgpbjAmwf5jqYfmrraHln2HKLo5ntGhYa8vwZy5C3+j+wDieI
 VlBHZAGHZVo6TQX1a4eZMTBlcv9d5gDOH201gzS7ZBZblvz9JCnoQZ08g/r8fjBLUTdg
 xKahjOD0smAOoyvwCT/s4q3bOeQ6Kv71aZP2PYqf/e/5Ds9JVDoriDpkwaqg3wbhhdsj Sg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bsqgmjw9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Oct 2021 14:33:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19JEUn7E053877;
        Tue, 19 Oct 2021 14:33:38 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2041.outbound.protection.outlook.com [104.47.73.41])
        by aserp3030.oracle.com with ESMTP id 3bqmseunr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Oct 2021 14:33:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwNXAJWFxzA+kKKKI4fXngdvfqrNA4IlXjMqwI9frZ16IXpHsp+ugUBR1TBti4NGpCJPis0Prqfr1ptDLZyGCO70JrL/bPmAyjvg6PdNhTtag2ZrU3xffjUN3KgsdZMzOvytSWYfqtIxOoeATpP4nfMncvG2vuDKh6vSh17HDs9VLggScryHT4vvW1BZxHuHb5JI4XG1OFWtSGP83zs5TMWyb0iWdNXvLdpbMyfaR4OtFGXQNu6PITDmAUEooFxRfw5NbX7pQPA7s+Pjunkda/DkTKuipg16YXCHwhrPH4GqIz/2BlC2uieutXUAnGtrrbhNtMYUL4MFg6LNxPmOJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4O961XxPNtZeSnz2cO2IYP7kxlULfchL8aTc8dG3KA=;
 b=csc9z7DIcWOzLDe01ekxB3EVhCz19jKyyOcPAcLT6G4AkaBR3vpX9ri4bXOfkvrrZoFGWBcAJ0YYhrBZ/C8nEu6tm3z4acAodlTg06aKzH3Iz3Qh6XP/VhtBFy7x8wxQQTmA6DnzcdAxOmS+DEdlJIObbCYN5Pzug5ERm3o5WQ0JuGBZ/i4eRTayhRDxmmZPedP65XLhRnUeixzdzGPA6Q3cklGnSV0C6Cg6feZnAXpikrZUrVgyuTauSgcpNEjzzRLM6dtFLOljQb3YMZQz70s8iCTEaKmBX3kMfe4IjbxW+i9gPE3Y1qXG6bYtnpiPAc3XOP11dlZGrfVNUMUtWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4O961XxPNtZeSnz2cO2IYP7kxlULfchL8aTc8dG3KA=;
 b=DwOltxCA3BJuHK64oirdP8q3tPDmdiWd3Kv1/n/3zkN6Jyj3CZvtfjAMLTmQG+g+XczkqBFLXaI95ZnmphizPhdbBU/Hlgt+Y+h+fqbYivJGgTNOqKwUWGrvMAN5+Cy17qEcotT5qA9SwwW+JA8JWE0BZDHS/SSUdp0Ix3yJeQI=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4386.namprd10.prod.outlook.com (2603:10b6:a03:20d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 14:33:36 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 14:33:36 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "cgel.zte@gmail.com" <cgel.zte@gmail.com>,
        Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] NFSD:fix boolreturn.cocci warning
Thread-Topic: [PATCH] NFSD:fix boolreturn.cocci warning
Thread-Index: AQHXxJ/Wv9o3Oub3V0qj0+G2Tv5Mg6vaY1iA
Date:   Tue, 19 Oct 2021 14:33:36 +0000
Message-ID: <B9D7D22B-EDFA-4144-AFCF-A66E12CB073B@oracle.com>
References: <20211019041422.975072-1-deng.changcheng@zte.com.cn>
In-Reply-To: <20211019041422.975072-1-deng.changcheng@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb2e128e-e3ce-4a69-22a5-08d9930d6f5d
x-ms-traffictypediagnostic: BY5PR10MB4386:
x-microsoft-antispam-prvs: <BY5PR10MB4386C405E26CC83B8A379EE993BD9@BY5PR10MB4386.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:626;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vJ1GtcaHC10+xQlBvS0bwnPZvp/HCKGjEewbxVb/0OsFPfHGOajHDnuz9eKOIUu1czxMAmxhPtax/952p4bztBuP4/wdtemrfRNrEVrTinxRku/6OU0YXBv2Z9t/8NOCiAsktSpyfKKVxqrOm9d6GBFUHFWnhK/sFD1gTIi6K+sc6EuHvDxqrYwc6JRSnwa0tYaLfHQtHaMx4pqvsb8OuBJanuOp6viOwbBMRk9RqtBvuhLQBBCXBxVC8gwAKJFDgXktyXjmcURk8jwPpJ6FGFbHCEK/PARlV6xokmDPSgzH19qWl8/BbEA4fxrI8bdJXZUNDHqFTkOo5Q2kImj9uUt8dNndhDkuuzFESQz8c5HFQgIykR7qDoJYyEpL/TGY4TCzW8Td3CokWtzouLBgV+HZ95it3Vbx9VjFYMl6OuLoIlAQ3V6fCgu+GtQ6Z6qO+ZT4UCnKrFEs4SLS3YuDTcCNaeXJQJoSUVZIvLKVeJpl7pK9YUdfnUQEkjXoCnexRWttd7EiwVju6ol/ZQ08zfYHlAg25bml2eBnmpztVtnhK2RQCj8Ozxs+0iltA0rIYMR51c7OGp4wOfCBxLA0RKjrVkwad81VD7jvNF/T2PzS+YfS/Am/KkFJh/GR04ZA5UKYhMxzX7gAcdEv6HL7KAIOCJsHkB+YmD6Ydbi+NxMLBDWMUgTjn/nRtiZiRRLwfx/uCUQZDlUebU+Vchow5alh0hNV3fY6ZrzdRJuVgeMDjLRWh3ZCxYYzTMHWGAf3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(26005)(33656002)(508600001)(66446008)(86362001)(64756008)(66556008)(38100700002)(6512007)(66946007)(53546011)(38070700005)(8676002)(66476007)(76116006)(4326008)(4744005)(6486002)(6506007)(186003)(91956017)(122000001)(71200400001)(83380400001)(2906002)(110136005)(36756003)(54906003)(2616005)(316002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jN/+AU9/kzHgZV7oWie030ngxmQXtNwZVBjkndzmm6tC1Jb7jWNAGXJUWdjm?=
 =?us-ascii?Q?vjaRDn0Ltg47jCMBYq2q4HoOeO6IBNpyumnN2pg5nufS/f+FM3clhobKJQkf?=
 =?us-ascii?Q?aPzAbpJ4H6rvpXXj9taRgylD8jn4LulP69CubNBx5yureTjP50VtPFnJExWw?=
 =?us-ascii?Q?soRLNkPPsJzUgSkI8HKRhRJM0Q/k9gSg/pKnyOSK19eKPvsdi8fcGh4QyRrR?=
 =?us-ascii?Q?weuKL4mH6nmqll8395dyrc1NKXbZn7yKZ3rdLdQi0vuGwFXZk0enDwxVcjVg?=
 =?us-ascii?Q?eLMMadxyjdeNhR8aRZTQowgR+84SVAtccN8w0ePGGyGGeKpXscR6Z4hwsMnB?=
 =?us-ascii?Q?pHynMNdss1yTgL9sS13DB8TVLpW7gHl1qRTEZGh6yWwgrfSIPOeU5Y/UkBjr?=
 =?us-ascii?Q?J/P8N3+Qd09auq9YzXPs0NIwV7s3HVyakq0DhFcJnG52xlKDgPzgj95zQ1MS?=
 =?us-ascii?Q?yIw1vN9i+itYiX/i3QoXK2FlcLJ3/eQXf9DZXctuuJmJXraOcH1ChuYTOWND?=
 =?us-ascii?Q?+fM8YX2gTL7mgR1dhRkSMbKrgozmrEcR6wmAjJNBJJSRqd58QTWvmEbESpvb?=
 =?us-ascii?Q?Unqb27ZriHU87yd28KnJMcwrJNP1rS6yFuVKsFaTtwRu3oJtl/edLyBOh/Sr?=
 =?us-ascii?Q?iKFh9K4Wo/GPHhMAJvqJQRqQl0d7a/cUNRcSjFeSaxqv/2ZsJueYMjVLJpDA?=
 =?us-ascii?Q?0o6embV+6cKi+LIoOspGxW8cgwqx/lQJV9cr2poj8lQu1aZtLE6SF6vZxB3u?=
 =?us-ascii?Q?+Det5eubOIuA0XqRneSmiqCLO0/UFZKS07Cr0s73sJwf4Kpt0h4wmQP0VU7V?=
 =?us-ascii?Q?UGQwUNMck78zHfK8J73jMkCaBfsr90bNN02VfQolXX+x1bArYjZt7W9eDONs?=
 =?us-ascii?Q?x1aGEJvlb+caB6UYqEbQYmZ+TDI5FCA6dDPnHuOiy9UVOceihwXDrNuduUmB?=
 =?us-ascii?Q?KhsXp9T6gH2de2WySnM2eNxzR7tqJ0gRIThRmzcNeeWZYh+ZYouf9A3DtB+g?=
 =?us-ascii?Q?9mjveO/IfyJqgEwgnBQACn5mhOjvM75Bd5vb1kBOVh/+3JzyNbabI2UP8Y/c?=
 =?us-ascii?Q?qsrzHp1D8S8gbuBu3alqNhUmH5fSaHMS8Xu+DuN38NLLtMLibYoaZBKlmw/y?=
 =?us-ascii?Q?xEmIun+MYtdFlZ2gto2oe9HNByXTGbJlDOXT3gwuzzIHNoXjsWwnyjGJbqJU?=
 =?us-ascii?Q?jQ6GR2g6QTqRDbh/N+nlyOO/d3G0b/DMvW8dYrFX/XO3SauWkfED8HcJugK7?=
 =?us-ascii?Q?cp3E56S56vprqU+zqZuIpM6F3wm1qU+XPdnUPq3uwfxrMGDv/fqzaGlQS18w?=
 =?us-ascii?Q?VjnhGCAvfbS11h4INj7pvJAD?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AED33ADF34F73E48BE7149686E9060E8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb2e128e-e3ce-4a69-22a5-08d9930d6f5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 14:33:36.0992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9WAm2W6o1WYRsepfV9IDKZZcDE6rjs9N/NLRNYYgQErrapn4um317DlJHdy0gwLXIGGnIki5Y6oscgJMRFc8MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4386
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10142 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110190089
X-Proofpoint-GUID: wQOmDvM2isZaWARrwysACv7s_-lr2AaH
X-Proofpoint-ORIG-GUID: wQOmDvM2isZaWARrwysACv7s_-lr2AaH
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 19, 2021, at 12:14 AM, cgel.zte@gmail.com wrote:
>=20
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
>=20
> ./fs/nfsd/nfssvc.c: 1072: 8-9: :WARNING return of 0/1 in function
> 'nfssvc_decode_voidarg' with return type bool
>=20
> Return statements in functions returning bool should use true/false
> instead of 1/0.
>=20
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>

LGTM.


> ---
> fs/nfsd/nfssvc.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 362e819ff06a..80431921e5d7 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -1069,7 +1069,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *s=
tatp)
>  */
> bool nfssvc_decode_voidarg(struct svc_rqst *rqstp, struct xdr_stream *xdr=
)
> {
> -	return 1;
> +	return true;
> }
>=20
> /**
> --=20
> 2.25.1
>=20

--
Chuck Lever



