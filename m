Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754D237AD37
	for <lists+linux-nfs@lfdr.de>; Tue, 11 May 2021 19:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhEKRlf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 May 2021 13:41:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38724 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbhEKRlf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 May 2021 13:41:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14BHYvY4064480;
        Tue, 11 May 2021 17:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=osQBwWpsP6F3W5UEyJJt/tdWKNEBvMSQ85QDCKPBfEQ=;
 b=SE6N0sVkmBV6fNt8QkyZjhb5WDe0jwCcx9uxc/7h/bvNVDLGfvCn90cz1WVzic2N9hX+
 zpNIrlzvdSJxuV0FsRHonZZag7ijoz9U+zJBsUVYs+qK9UnJC8CWksTK4kQ8H2sZP3zv
 T1ITZ91f5hDghX23kKU9cUU4np7nfU1QI3vVUh8yYwRzmH7mDxrnEkdniSkpWH8oHZYN
 3u94BX686mvd9c//2Cx18CEAfP0I2NRlnOYh+B1CGvRJSaHJR5oLBF+C+S140vK2hprD
 l0RaDrmaj5PrnTisl0XTQvhI3flpQ4tawiAn8VqyB1XMtGmrgn9Eul9yg7Xge+LdDkxJ Sw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 38dk9nfhcc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 17:40:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14BHYhEa146272;
        Tue, 11 May 2021 17:40:22 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by aserp3020.oracle.com with ESMTP id 38djf9q45d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 17:40:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzBMWXSAA7tIAOUP3J8BZ+NBPRj3R/IWn/gwRr6JM7BQQ3vG0VBKZJVkh44alBCUQdvMI3w2UZaaFd4k+gzsW00hOa/hTJMM0NF+qnwO8usE5DmL3ggF3pgUVOcnpcu6HGJ4eE0DkuuxOvHJyxMhhgIsqce2nulthryRmYu2pPvehh0Vh4okSaPn6Rba3To50Tbz85Cmcc5XqZ+8I9ykzj8fuJaz0CXFp7ag78EVKwPv+TbqcFtotEeVEKHUF3DKXRIeXmy9WmqvWxJowNQmedaCjL7SiLyIC4pjRhDTcx+Ug0fYmT1Cz1T67rcglpCn2iUyqLzY7PV0LMFCz3SLDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osQBwWpsP6F3W5UEyJJt/tdWKNEBvMSQ85QDCKPBfEQ=;
 b=UE14k73R4hgiROj6QGoGYNfyZSdLnyv7iX8+IPsxXShiNAGW5j2+N6zKBp4//EVfCHhYmhL6q7ak9yCuTgSlFwXbMbFr7KPaf6/dQB8nSLSnmpaPt5WHn6UOp18Drw2sa1F9BvSl94pSA+sJ0sU+n2eK30RXDOua7XVNmhZEJE8NEwnHKvNM27T7uDVHE+AV9+1fIj8qVkwk53Y5GjWXSbHDOhLVqd8wos4wSVozS2zxQ48pj4PVNNfi7UgiBclTj+1wLXCo7vYd+Ylv2y+RhvcTUyYd2ttmpXGCKlTf+jHpBA3UEKI/wvcgGsZ+YxxZv36Ccu5cJ0ebyZvgV9Ieiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osQBwWpsP6F3W5UEyJJt/tdWKNEBvMSQ85QDCKPBfEQ=;
 b=SPTLaa7vbhc5udhMMg9geY85m/s4aqvxQ6XC9GRRV5SDju8d7PTkNgw97sf/k0BWi/6IZ9/lXyY7KRDn6CORnoVDgndakmzNioMD33m1ugPp6/RojVbkRCeXvWnbbaV6Y3s2pAfr7tJm96N53vLRHPF9fI39ukNpKSdPA7L8UCw=
Received: from CO1PR10MB4673.namprd10.prod.outlook.com (2603:10b6:303:91::8)
 by MWHPR10MB1533.namprd10.prod.outlook.com (2603:10b6:300:26::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Tue, 11 May
 2021 17:40:20 +0000
Received: from CO1PR10MB4673.namprd10.prod.outlook.com
 ([fe80::c4bc:1a7f:322e:55f1]) by CO1PR10MB4673.namprd10.prod.outlook.com
 ([fe80::c4bc:1a7f:322e:55f1%7]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 17:40:20 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Wysochanski <dwysocha@redhat.com>
Subject: Re: [PATCH RFC 21/21] NFSD: Add tracepoints to observe clientID
 activity
Thread-Topic: [PATCH RFC 21/21] NFSD: Add tracepoints to observe clientID
 activity
Thread-Index: AQHXRbSucZYUv8RjjEGtdKxv5mPBy6recbEAgAAb2oCAAAB3gA==
Date:   Tue, 11 May 2021 17:40:20 +0000
Message-ID: <87867BC3-EA29-4C94-B8DD-6B927BEC9522@oracle.com>
References: <162066179690.94415.203187037032448300.stgit@klimt.1015granger.net>
 <162066202717.94415.8666073108309704792.stgit@klimt.1015granger.net>
 <7922E4B6-BB7F-4D9E-B85D-D1A97835AF3F@oracle.com>
 <20210511173839.GB5416@fieldses.org>
In-Reply-To: <20210511173839.GB5416@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df60c34e-e061-4e4a-335a-08d914a3d908
x-ms-traffictypediagnostic: MWHPR10MB1533:
x-microsoft-antispam-prvs: <MWHPR10MB1533A416A44E17778352B35693539@MWHPR10MB1533.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m3BMI9OtTKE5hO7jwBz/pZ7ZPYhMktk4HFggvX2F3HI74rNAe6X5GlyjMI2F4yd0bY4YjGcWb8Brq+X3yu5NDARNdvgqytAm+GYCI2uf4qeiEcc6icbRCELLjjVQfjfM5i7B1Gx1IpfWqQ4q8vUCfTF3Q5K0t61mX8gDMoiZW6KMtZKbM9gvp0zBzUIimgS5nSeQerFKz6MJPsHr/uvYyFkQiYMafXk0g5LDNvDyWMYFvLcvO/giVXBcLdqFyjc4BJCYSGQIPRd1/rfL6ECerO81PQzHMs8XzVbTWqrZjyxAIx+CObrc6UUe0Qfulv53eIt5ZgcNM68dUsvh4YrPqTrtM7erlM56B910GmezP8GL9y3WxZ22kO0ubfiBYhgreyd+VkYqUWTt388IVWqxDXvhV3g72MTNGPQ0njWpPe2byNq30oKU8BSetiedlf10Ftl9Oml70i8sbmxGb/Tjb1fdiGjhmG5EiMobu9KE/IcLKT9PoLV0GQ98+q8eBLuQ7FcbEJhFLPBbdgKkQ8qtTKxAzAsYuVigvWZ4/nTA7y4E/s8DXcQlbEEjoLzQWW59vsQ9YcyjuBdUARuBqKuhScM660NP6XeaiXf/N2oeDPcAQ0bKnVF7EdgiLZ0ydl7bAzBiWT7vA2XOTyTdF3INEqDg13Cwczd4U2gspW9iuSE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4673.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(6486002)(122000001)(6506007)(5660300002)(53546011)(2906002)(38100700002)(26005)(71200400001)(8676002)(8936002)(83380400001)(66946007)(2616005)(6916009)(66476007)(91956017)(186003)(64756008)(54906003)(498600001)(33656002)(66556008)(66446008)(76116006)(36756003)(4326008)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ee++ILZ7uBaKa3aV+PdNVV9+UK/8oHXfmHUB/eOHXnEmfszR4fM18P8UQ4fU?=
 =?us-ascii?Q?m+rpxQEKNOmkaQq8vr+9WRvO3D9ApUgpTAwXraYrEXXT7XcRA8IBhyzUBv0w?=
 =?us-ascii?Q?iCRVa7va7T9ZIJrwuQghiTZKHO+MZO2TU1DbQyNnBzbZOPK8h7NbyyflFkXi?=
 =?us-ascii?Q?s0PfBvDrcmFCJI/AmdIT+5mqz5tB1rytYCGzSNwT3ChsGdKd365JPUIsdC3m?=
 =?us-ascii?Q?YPpqgvH86xj+DmHXldmyFlPXpvkMO+7CeoJL/JN280aTOVSqLLO3p7n8Ijgm?=
 =?us-ascii?Q?rmBie0uyuMFCrNfvfhbGu/nue1nIyhoRZt1ruz/Yn9X4D49fQ19ZQNS5ESrE?=
 =?us-ascii?Q?rumoZyHjkUs5Do1YYLsoOPGYHQethfRs6Ozmqjhvgu+WgqUBv0ulXiRH9dPp?=
 =?us-ascii?Q?FWRgPXJgU/OxoFMLba0hjjricvCGFjvqX4gsaqQTP0adhhCMCaHXF80N6L9Z?=
 =?us-ascii?Q?Hn7qePIhRIECgLCpfSEe4c+wydgAmvXHzyheIByH2H3wBnZttA+b621ZeX/3?=
 =?us-ascii?Q?jAgaXlix2VGPDFWnBPhyYbC9hPTyq/XZSmnycgqiWRje18ilTXh+sgNJTYWo?=
 =?us-ascii?Q?2CKMQrmlhaIgHKuKjs59fFjiqLZiif6KTkLgE30/Nx/Rz9JcpmfGLmuv4//D?=
 =?us-ascii?Q?CVLt+8B/PJa1ldACM8Uh6jglyJVJ3dHcw3s6KPKw4PmkAc3RPVwHwk64Dioo?=
 =?us-ascii?Q?74Yygf6KhLVbN1+HtqLkm0ZUdxsX9BxUGFNzLkqo2viC8oRfO5Tst0TsGSTg?=
 =?us-ascii?Q?LLp7m1/tG3Y9lUyz5cfYH6kuXzv+aPxF2Eog2Bq7RUgVF1uwzsPJgSVUCJuP?=
 =?us-ascii?Q?sw+kB/XnyDUcGoKXXhypQCq75DxRyMJk/UXwfigUsPUfqM8pW7B2GECfr1Hz?=
 =?us-ascii?Q?DHqNgA1IxlqredYtSHaOUvY8Cou4E20351D8vmWogNKtrDKWketBmKllg8y3?=
 =?us-ascii?Q?j4ms2jHFl2Y1vjgIXy/ch7TT2YLBjkRe5w7S5cGARaLUfOVrIcBixQ4a4sRO?=
 =?us-ascii?Q?pgoqkyrI8cV5lRktstTJNpQfgUKDJ9Sk1swMYttQxD3S0JcHKCuYgrqwDgwY?=
 =?us-ascii?Q?Bc+OcH9HwVRhaDIZgdf+Rsn+jam9MWi2AHn6zqiwMsXd/FwQjBqTvNg3dLTC?=
 =?us-ascii?Q?4hAQREmF28V1wLl7rySo2C2ZzJVNDW31ujLdldXMXhfqhSkOZBJkUzyX0qEB?=
 =?us-ascii?Q?G5lebPIGV8Uv5oaqJNo/3sE9YTnIkBwOfP2S5Cj0yDzQGhAPFoTJJKe4YHW5?=
 =?us-ascii?Q?IEje6LN18z+2I3toIvWVK37VlzRGEzn6dPuXa7rNFRkldnbbIAf7ACUpJ7AQ?=
 =?us-ascii?Q?b0KGK2Wna5VnJe1C/fYmbPBslZnD0f+RYF6w6l1UFadvcg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7A99FB4C65DD5443BEB3CF1308E80119@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4673.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df60c34e-e061-4e4a-335a-08d914a3d908
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 17:40:20.1530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9FAeiuiwdYbi5WWklsQ5oIhxdJCWJF5HCjLk+Elo3eBU4iiPMBuQkI/ydcEdj/U+Dw8a/Ag2/5hlbRiuQSwFYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1533
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9981 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105110120
X-Proofpoint-ORIG-GUID: qgjJGawDtLeUvGm54Z9b61Q302Esqlgi
X-Proofpoint-GUID: qgjJGawDtLeUvGm54Z9b61Q302Esqlgi
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9981 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105110120
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 11, 2021, at 1:38 PM, Bruce Fields <bfields@fieldses.org> wrote:
>=20
> On Tue, May 11, 2021 at 03:59:00PM +0000, Chuck Lever III wrote:
>> As Dave reported yesterday, this patch is unfinished and is probably
>> junk. But any thoughts on how the tracepoints should be organized
>> in this code would help.
>>=20
>> So I was thinking we probably want a tracepoint to fire for each
>> case that is handled in this code (and in nfsd4_exchangeid).
>> However, this comment in nfsd4_setclientid:
>>=20
>>   /* Cases below refer to rfc 3530 section 14.2.33: */
>>=20
>> Is confusing.
>>=20
>> - RFC 3530 is superceded by RFC 7530, and the section numbers have chang=
ed.
>>=20
>> - The cases in this section in both RFCs aren't numbered, they are
>> bullet points.
>=20
> Honestly I think those particular comments should just go.  The code
> doesn't even follow those bullet points very closely any more.

OK, I'll squash this in, and include similar changes to
nfsd4_setclientid_confirm().


> --b.
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index f47f72bc871f..2aa5d15b08ed 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -3954,11 +3954,9 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct n=
fsd4_compound_state *cstate,
> 	new =3D create_client(clname, rqstp, &clverifier);
> 	if (new =3D=3D NULL)
> 		return nfserr_jukebox;
> -	/* Cases below refer to rfc 3530 section 14.2.33: */
> 	spin_lock(&nn->client_lock);
> 	conf =3D find_confirmed_client_by_name(&clname, nn);
> 	if (conf && client_has_state(conf)) {
> -		/* case 0: */
> 		status =3D nfserr_clid_inuse;
> 		if (clp_used_exchangeid(conf))
> 			goto out;
> @@ -3970,7 +3968,6 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nf=
sd4_compound_state *cstate,
> 	unconf =3D find_unconfirmed_client_by_name(&clname, nn);
> 	if (unconf)
> 		unhash_client_locked(unconf);
> -	/* We need to handle only case 1: probable callback update */
> 	if (conf && same_verf(&conf->cl_verifier, &clverifier)) {
> 		copy_clid(new, conf);
> 		gen_confirm(new, nn);

--
Chuck Lever



