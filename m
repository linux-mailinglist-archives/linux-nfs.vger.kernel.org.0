Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26921611B34
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 21:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJ1Tuf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 15:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiJ1Tue (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 15:50:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DB242E43
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 12:50:30 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SIxSko004101;
        Fri, 28 Oct 2022 19:50:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=+rR80gdG0+eOpZNdLq/FlksdyG3vB1A8+HYm/8LzNW4=;
 b=a8oq98a1c2cLIUBYux0To3JUsyxbodIaTj+z849oL5sylfr8hdPqVPiXUpLa93a/1qck
 cvgVJxZBlkTLuMHhY/aE2UotOv2JtdxLesCKNv+n6GVQ2cZwoL/mX2N7rB65yeb8WT+q
 lUJ9qa1DOU1qi+5kSTPyKYGB97EY8oIL5rWd3R4BvDXwFKp8zRe40TJBzdWw+AuO1LDB
 ysKhSej91kU/ABQ1UJ5SVqXQO198yd+9o3/TBS67lzV/+P/aDpH0A95ovX4WHbgFw3Qc
 YasJCZ8pl8QyT7fIL9wSdcaXkzE3O9MkuqKl2tutFg8/Ln7HEdFoliVVzFVDu2ZqKyQV lg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfb0any04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 19:50:24 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29SHoPMY017417;
        Fri, 28 Oct 2022 19:50:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfaghvu8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 19:50:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjZiSvRh3gafL4pNtzerjIMRqqMWTCEXfvwKzLXRGJpPZ1IZf70D5zut+AUuPWe69N0mB25i5lAEG96qd9JWiZXx8NSyM/zCMJVt7Zl9nLHorgJXPv35toT8ACbAyK5XGJQIJTVzq/vt5zCJUbhG9cf1DxLeiISLGdVAXbF9NA4vPN8ULgb1litRIzj93bbTkuHnZ1UHSL0rn+GOnp5DL7mY7fL+NTQSApQRBNLbuRs4TENmgnyLvFH/3BE8/WF8eBMVEpw3rWJPZAKZztfaxy0i7M9PjsetZc0scP2Cr0HDFyRNoP88vZ0f8zclD81JpCOJ/K6hlcmV5aaD0DNGnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rR80gdG0+eOpZNdLq/FlksdyG3vB1A8+HYm/8LzNW4=;
 b=E4LNEnjGS+2h1cF9yQ3aO6mNU6lNP8CAB+mleUICbxfogi2eh21yfVY+ECL1/tBMmaT9k3xxjjk/nRHR77tpUs1ivnAyMjMYsIxyGeOWo9kEAiXHGPWgyN48rtN6N4svSf7GF8mSZApSK7y8AilnWCjupZbkTPG21ZAvVLH4BRMU0/ofz/wIxwfYVIz/xM46k8gL742p8X0wiwzXlMmYcHfzP2EDOxT6v0ztXZJaqmGtwMtvk5uR7S3wqfqmfSXjloGXrkoUeU0UeGn962FK8fxN37bxO2D8pV9leK5NMsuGHh08HN+FKOOaADdH6zeI1kfMK7fZRLg7BqKVS4r8kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rR80gdG0+eOpZNdLq/FlksdyG3vB1A8+HYm/8LzNW4=;
 b=WoUmeH2949phF8dxSrRpKj65Pu0sCyXO+f1lPfrfJKblipsXvHfeF6+x61p/wLrf2/crSoxg2eYUemrJZQ+O9XebidyFHjgRGW49Oa03jXlRgwLHqra836vujaCGagNINtIq10g/eRN9eno7YbqJgW4M2vV+9sHBqNSluVWTlzk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6086.namprd10.prod.outlook.com (2603:10b6:8:be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 19:50:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5746.021; Fri, 28 Oct 2022
 19:50:21 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Subject: Re: [PATCH v3 3/4] nfsd: close race between unhashing and LRU
 addition
Thread-Topic: [PATCH v3 3/4] nfsd: close race between unhashing and LRU
 addition
Thread-Index: AQHY6v8bPfwg35VNl0uAHle+vjwISq4kNwiA
Date:   Fri, 28 Oct 2022 19:50:21 +0000
Message-ID: <08778EE0-CBDC-467B-ACA6-9D8E6719E1BB@oracle.com>
References: <20221028185712.79863-1-jlayton@kernel.org>
 <20221028185712.79863-4-jlayton@kernel.org>
In-Reply-To: <20221028185712.79863-4-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM4PR10MB6086:EE_
x-ms-office365-filtering-correlation-id: 5afc4b5c-b478-4b99-f257-08dab91da61f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +YSHJKT4S4w6/coHbYif8r3iCBbyyNNjnq1v5uNws4NK24daP/m3tiE2ue+lQdm7EWY2cA/qvl5lbe0wnJ6W+8OO+2G8kF7tNVvI+janYbF5YKWfxtivKjkOSpFyC8lJNJDXqStstCs4PXNcLmcQs9+yY3yxD8DRAZyzDAeytSPu7jwOUQ2aBaUfv76yk720gzY46ZeO3OajQAATxjmz4Js/9qXGSoyUcEoAR8R5A51VHK4O1RAC1/3/ZVzZAt5RpKlqq3Qeqtelq3QucnJr8YIbl30MZO3205Qq1BRZTH8KXA0GL5FvgC6pCwXRXl0n1ZSF9A2mifeFCp3zKNYDhqtYFlcTBS+tTO+Sd/OfTzvimaEmEkEqoIsgiZwKUA3SxkAyJ6+olt9OYIO89YadhvZnm7DTiibOieWsXwMyAPUXUHRr2b8KdjLHLC79Ko0NT2n0e3SLQVAUmJbPsR3Pw9ZyDvhKzr4Xyc6tFUTnDxdVykXBO5b/G39ZfRJwktm4k9UhgGDEFWy3tBV2Z63426oi8wD8odZdDD7VF3xVt1wTi6iiI2yyU75pcIu6RiR0n63YZRPc+Nw55h//QVQsbCOn/BKUsFqLO7e2aig1DPdrF4x1qEqvuf9z//JAqcEVwsm3ZWmFn/RFkTg8dpiK89aHdFqll8HP2ROWrj4GInxehQVB8VXJWwY4mGR6eZFvcn8rBDJTDyBgcdXNZ8JwFqeSqbxCo3bLDlELza08vFupBdfyBmShB6jch8+9cXbPyiqGkbxH+8FvthNMU2999Tx+1ftcrz3wd/6qupQ6D4U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(346002)(39860400002)(136003)(451199015)(316002)(54906003)(6916009)(33656002)(8936002)(41300700001)(71200400001)(38070700005)(76116006)(8676002)(5660300002)(4326008)(91956017)(66476007)(38100700002)(66556008)(64756008)(122000001)(66446008)(53546011)(6506007)(86362001)(26005)(6512007)(66946007)(478600001)(2616005)(186003)(83380400001)(6486002)(36756003)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L38skDxZYrMAT/fo+5gqt9A8IjmCuwH4xmV3kCM69fY7xwFjNrCQ0fEcZwdB?=
 =?us-ascii?Q?wC/oWuso+g9xmjB8GYE+j1IDidE3bxizEOJ0rfaagRQCAVimcVxUkFVA+1CT?=
 =?us-ascii?Q?p51zXzWDkW1MEMO717uJv50o4+2UXE/IRc8LWIWRAWYqx4ZNwHH2hBppFy6o?=
 =?us-ascii?Q?LU1fsTMkPcRqAL04X+TJJwOXTqODx39s7HGT2l0/oGnzDs5yMXKpr9p9HZeo?=
 =?us-ascii?Q?ODBA7pgmsGepuc/sdRqU+Fv49aQdskrFyE6jF6xyDPZvuMO4EpFE366WMqK4?=
 =?us-ascii?Q?t0zaH3AtazbOhGxEkLcv4OW6Qs6Q7yvN5XXOsxFDA7e5jpRVUn0rE7x1kRM0?=
 =?us-ascii?Q?JZHIBCW7vccn1GJJ7zmiaDXCUBLb9HIuC645ijZkVNXrGS+D4SVodWV6RTo6?=
 =?us-ascii?Q?3DX5pp9PiI6Kk32J5eoU9kyiABXsncxk/cR6dzw+6lmeV2P/2wpjL5jc2tYF?=
 =?us-ascii?Q?IiMwM1QPp9DqAx295FqdyenCupgWmc1Hs7ZQNAyrf/9PjC/QsRGSdtDUgx1b?=
 =?us-ascii?Q?769cqyHMUn/ucSBKYvdlJcFCbFfDR/FxZeMdUoMtSOkP4coHlUOkBdTky3MH?=
 =?us-ascii?Q?zMYjDXOV9A55irygQDTx7KoWbv9bIfZPGyTeXNfc21Gk9ITrEW2Y/qRW+0WW?=
 =?us-ascii?Q?R++xQYwOyZ7H2+ojoZfp5sIAlD5acvnGhIrCUFYkX5QGA8It5ioUHoZK8AxT?=
 =?us-ascii?Q?sWrTrKdMT+t0c5mHXLfV6R48ybEIqnZwa60Og0COwU6JQ8P1Abab/tYeVEcD?=
 =?us-ascii?Q?I2lfp3ucWvWSKw2EAhbnHIM9dyZqIJg9c4+Pg/eNYb3uM4Qx9VuXyIG1WBEY?=
 =?us-ascii?Q?kqLm01OJeKG3xv4hh9bcZb6JaiLEwfh6RbBkZ+/qilCC9UXrk33cJ+Y8G2Jn?=
 =?us-ascii?Q?7JGFY8vujC8+CypzXBNr4Z3Wv9Kjxh1Pru6TAa+FUT47QdBJHH3avEK1VHwh?=
 =?us-ascii?Q?4FWkpxR+TO+mIJ6b62G++N/IjuDjjsJsMxCelZQSej1uNKyJMfUa/fMsjnz2?=
 =?us-ascii?Q?mytFSbevJ0i6dfGmVWbuDiFW/wwsPxmH7szekJ97dc134X6ekzdDkqCHTSY+?=
 =?us-ascii?Q?ofWB52zUGHSiMuL3rWls8AjRpr+c4FjCzrv+MQOpipA5AuP13Q50PVcWHGxr?=
 =?us-ascii?Q?Rs1EFxYfghOOZQ39+fx/AyLa0Y3RW2i4tt1Bb1C+1Ar0e6Gn8JUxzeJOWEfH?=
 =?us-ascii?Q?CRhiav1OlYCn4nkoiwLaipl8vIMv4GTfkJ4FE8XdH+1aipXOhowlaIi21WCj?=
 =?us-ascii?Q?ACStQG0JWuD4Em8K8Ta0hsCmG4gto+P+MT4/DPkPkXKEYb8JvgXbdP59ezf+?=
 =?us-ascii?Q?ky+b7f6QZkbfXEAy9R7q841gKUthDo8boQR8F3D2BOkOZdyD8TIIH0voWGOX?=
 =?us-ascii?Q?rDX1tEU6sOF1a9QxzPjoK5EPMlu8IAmnix4dLE5vS01LeHs9czeAMlrpqqck?=
 =?us-ascii?Q?acaSV6Oy6XzroF3Fg6N6xPHHujpJS7444fZVx79EogleuZ7WcmjL+IvJnfhX?=
 =?us-ascii?Q?uig5iOO2JK/U75n4tpOOp3iynkTIhegs1k5GTBbdY/fzwwPe72kJwZ2w9JxN?=
 =?us-ascii?Q?7sCQDoRYttieBYhtD9891pfBkiZ5wBZTnNCIklfGwpFCJLM07Xi6klxjfPne?=
 =?us-ascii?Q?GQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7A4DBB6F1AEA6742B8803A3ECDBE9FCD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5afc4b5c-b478-4b99-f257-08dab91da61f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 19:50:21.8335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qqtRBdiy4MNuzW207VvzhpXFp4actQ8QtPmLUtmV03KfMuqHa8h8TiLXt+1XzD/SdoGCZDm21s6YhuEpLnKBbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6086
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_10,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210280125
X-Proofpoint-GUID: z_zYiE2eqaKBLgC1nIfCkLpUAfAe2nmH
X-Proofpoint-ORIG-GUID: z_zYiE2eqaKBLgC1nIfCkLpUAfAe2nmH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 28, 2022, at 2:57 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> The list_lru_add and list_lru_del functions use list_empty checks to see
> whether the object is already on the LRU. That's fine in most cases, but
> we occasionally repurpose nf_lru after unhashing. It's possible for an
> LRU removal to remove it from a different list altogether if we lose a
> race.

I've never seen that happen. lru field re-use is actually used in other
places in the kernel. Shouldn't we try to find and fix such races?

Wasn't the idea to reduce the complexity of nfsd_file_put ?


> Add a new NFSD_FILE_LRU flag, which indicates that the object actually
> resides on the LRU and not some other list. Use that when adding and
> removing it from the LRU instead of just relying on list_empty checks.
>=20
> Add an extra HASHED check after adding the entry to the LRU. If it's now
> clear, just remove it from the LRU again and put the reference if that
> remove is successful.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/filecache.c | 44 +++++++++++++++++++++++++++++---------------
> fs/nfsd/filecache.h |  1 +
> 2 files changed, 30 insertions(+), 15 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index d928c5e38eeb..47cdc6129a7b 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -403,18 +403,22 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
> static bool nfsd_file_lru_add(struct nfsd_file *nf)
> {
> 	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> -	if (list_lru_add(&nfsd_file_lru, &nf->nf_lru)) {
> -		trace_nfsd_file_lru_add(nf);
> -		return true;
> +	if (!test_and_set_bit(NFSD_FILE_LRU, &nf->nf_flags)) {
> +		if (list_lru_add(&nfsd_file_lru, &nf->nf_lru)) {
> +			trace_nfsd_file_lru_add(nf);
> +			return true;
> +		}
> 	}
> 	return false;
> }
>=20
> static bool nfsd_file_lru_remove(struct nfsd_file *nf)
> {
> -	if (list_lru_del(&nfsd_file_lru, &nf->nf_lru)) {
> -		trace_nfsd_file_lru_del(nf);
> -		return true;
> +	if (test_and_clear_bit(NFSD_FILE_LRU, &nf->nf_flags)) {
> +		if (list_lru_del(&nfsd_file_lru, &nf->nf_lru)) {
> +			trace_nfsd_file_lru_del(nf);
> +			return true;
> +		}
> 	}
> 	return false;
> }
> @@ -469,20 +473,30 @@ nfsd_file_put(struct nfsd_file *nf)
> {
> 	trace_nfsd_file_put(nf);
>=20
> -	/*
> -	 * The HASHED check is racy. We may end up with the occasional
> -	 * unhashed entry on the LRU, but they should get cleaned up
> -	 * like any other.
> -	 */
> 	if (test_bit(NFSD_FILE_GC, &nf->nf_flags) &&
> 	    test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> 		/*
> -		 * If this is the last reference (nf_ref =3D=3D 1), then transfer
> -		 * it to the LRU. If the add to the LRU fails, just put it as
> -		 * usual.
> +		 * If this is the last reference (nf_ref =3D=3D 1), then try to
> +		 * transfer it to the LRU.
> 		 */
> -		if (refcount_dec_not_one(&nf->nf_ref) || nfsd_file_lru_add(nf))
> +		if (refcount_dec_not_one(&nf->nf_ref))
> 			return;
> +
> +		/* Try to add it to the LRU.  If that fails, decrement. */
> +		if (nfsd_file_lru_add(nf)) {
> +			/* If it's still hashed, we're done */
> +			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags))
> +				return;
> +
> +			/*
> +			 * We're racing with unhashing, so try to remove it from
> +			 * the LRU. If removal fails, then someone else already
> +			 * has our reference and we're done. If it succeeds,
> +			 * fall through to decrement.
> +			 */
> +			if (!nfsd_file_lru_remove(nf))
> +				return;
> +		}
> 	}
> 	if (refcount_dec_and_test(&nf->nf_ref))
> 		nfsd_file_free(nf);
> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> index b7efb2c3ddb1..e52ab7d5a44c 100644
> --- a/fs/nfsd/filecache.h
> +++ b/fs/nfsd/filecache.h
> @@ -39,6 +39,7 @@ struct nfsd_file {
> #define NFSD_FILE_PENDING	(1)
> #define NFSD_FILE_REFERENCED	(2)
> #define NFSD_FILE_GC		(3)
> +#define NFSD_FILE_LRU		(4)	/* file is on LRU */
> 	unsigned long		nf_flags;
> 	struct inode		*nf_inode;	/* don't deref */
> 	refcount_t		nf_ref;
> --=20
> 2.37.3
>=20

--
Chuck Lever



