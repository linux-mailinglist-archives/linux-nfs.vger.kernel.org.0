Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F6F4C4C25
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Feb 2022 18:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbiBYRaI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Feb 2022 12:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237679AbiBYRaH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Feb 2022 12:30:07 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC0B652E4
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 09:29:33 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21PH5U6M008281;
        Fri, 25 Feb 2022 17:29:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=64NrFgouwV1Vo/hdvSf2CG4UF2MNK/juAbRkF6/944E=;
 b=s1OaOrMGcx1mRUfBr1GGrF55AW8BNDUlmDGGF3KbHhnz1dFOuFbQTWuMzUuExJRyt3+5
 eYnLNd8xNwgtgJ96ShuLQgWHPu3RPUw9wrPBa5aEbOiBsBIfCtqmrF8IXmzkDCRyFWp3
 KyCulbYkIsN7FlltvxCyrLprCgUu9q1PJg5vOlll2XPLSOCzAscwA1gWi1XePBwMEdsc
 HhLXhf8Mb5pTLZ+6TxouHW3XL215gfKCgwITHC0E3EJLqRmifJd6Nf5/QBaURfDYQ3A0
 VVOTVjb9W0j/66C8CD87C85JEsRDCL+3WEJ4VXNBibdED6PFr96rRvbzRQkUqEFNZHji jg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ef09prtpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 17:29:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21PHL2CJ067994;
        Fri, 25 Feb 2022 17:29:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by aserp3030.oracle.com with ESMTP id 3eapkn314j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 17:29:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewM0u0rlcYZ83Ui8mgFD4jkCUfeiBDLEYDmCmDr7c8GR0cD7A8tfw80WNxxR7GfJSrbnKzhwx/tRwAqo20RLh8fRG4vKlbXcXrYxyiSHDSSS+xwQimMzugtbH8xaagyReXCIAIjiChrHQQ1pAW1mH3JKGuhbWLVGU7eWJ6CwTJSRJ3uBOyFyhYQBGtuUvZ0t5NuC81Ui2v0eG95vu6+y4ayojKytM+qYujCx5MGEuWwh5kgnsHGU9EcHy6Ug4xBVRMbw8/8V/ekZ+P/8r3oB25v3bKiijMe4UiIL0hhLJmNnftHWsVSKteRJBLCglIE3WAyO5648joF4bAeSc/qGJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64NrFgouwV1Vo/hdvSf2CG4UF2MNK/juAbRkF6/944E=;
 b=XuP9rko/83hHEpAWvIUR9xvV7TVOrHK/DBmIif9iQg+6TFNtfZuZ83gm/PHMYkllOfW53jZsTc3xxdtvxVVbqnj5eomOrQK33db6NlOWpUinxHgl2yPvLcrf5edvPRXUmyF+oY/bNGg0w7s+7NYXcaur2/j+wQTnZBnoTerkZe5ch6MEGoX5pAWEI+1KSaqv/dyYRbjOBZblh+qTFZ8OklXFIbwow3cCowPHlKeLg5cGt0Ug5ZBiJ4XwfFwvad2JW6+Wq7YbIzJxiXOOZ0i2IRj9iAHWyKy7NN8tyfp/wwHyPnm44yPqOikKzScNe+ugDXrUR9aRpaTzB9j1ENdKuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64NrFgouwV1Vo/hdvSf2CG4UF2MNK/juAbRkF6/944E=;
 b=tPUSQLzqLkvFMV2igPPMAAytSn8BdjRjW0dXcatYhA2H1B1u2++R/MW7jDvXhJyPApMWx1e880twrLFgfVpDjZm/CdWhMja9uh2WkPv+FfZqWvl38xkk6Ym5H/CxGppzOoUfl7WN6tqgL5w42j9I322mebU0CqyILFxl/YeMn7U=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY4PR10MB1910.namprd10.prod.outlook.com (2603:10b6:903:123::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Fri, 25 Feb
 2022 17:29:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%9]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 17:29:22 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC v14 09/10] NFSD: Update laundromat to handle courtesy
 clients
Thread-Topic: [PATCH RFC v14 09/10] NFSD: Update laundromat to handle courtesy
 clients
Thread-Index: AQHYKOGFvpYc1MpZY0y/tkmRdwDZvKykiK2A
Date:   Fri, 25 Feb 2022 17:29:22 +0000
Message-ID: <35CD78B5-4EF6-4C7F-A5C5-13BFE1E2175B@oracle.com>
References: <1645640197-1725-1-git-send-email-dai.ngo@oracle.com>
 <1645640197-1725-10-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1645640197-1725-10-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ff7452c-daca-4e78-6042-08d9f8845cb9
x-ms-traffictypediagnostic: CY4PR10MB1910:EE_
x-microsoft-antispam-prvs: <CY4PR10MB191080AEBEC95CD022C2A745933E9@CY4PR10MB1910.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5HccjVPods7MrttnOP1H6nE1E+s7UOQPUWeJBLRyDE8ssV0c83LcQB1sNMludaAB+b2AnmhbPXcIxyy9WslI7hYebjqUXk75HjsMDrBhBoG0uRkiZOwkICjHGHTxSQfJ2pjeSWKjTog2pwKYxA3+W2liv1RFUkGf26zlRzTUeFts4LxHf1OHqOnFTTyGH+YrtSW5G3GbCGna2xMTnUbuRoV4jgyfHjNmd3P0nDY4ITT7KnYeor64XI6V9ymifyak1ZdRPuM6IqnxJBwlJ6W2gCqkuSRBvecdkCJfE6S/SgL7/Gk+y7j1A6uBpx0OQsNlT/Jyv9LOXiSHCzlA2I511iuIX/3GKfw2jBjVFKHCpmbXtVbpzXjNdYEJbj40wxvAnW8WnalTDgCNQSZkts7sdL3QKD7QZg0TxTZNi3aDclIRcjcgLrFUhoGjjmBCMHXSl/UQ9ZQYhk0lUAO33XtWevtUD95jQISvdVYkPlPD4kqsUgxQFdKePPHR6wq/6hXZGK9n+/5ywdK6EuCgAgEQH3yJwRF5FY7BoVMv+p2+1f4JJYNKizeiUaemuIeTV+qlsLDaENsFcAWcHpncj347lDr0QP1A7Se4pDjKYnXypS0hWuNIog9Hj9tLcs+WfHHmBxdgJEutoukZJiB5VylFxMj8krkXEIz3IZJmPTOnph5giWEAHTX4/lvLvXCFJFjjcfjVdhr0x0sjwSdKj+wmnNL7A77GmPWTeCyROZWPMyqBTJsa0yzovRCXIVNKEwN/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(91956017)(38100700002)(76116006)(83380400001)(508600001)(122000001)(186003)(26005)(2616005)(33656002)(6486002)(316002)(54906003)(36756003)(110136005)(64756008)(6506007)(6512007)(71200400001)(15650500001)(5660300002)(66946007)(53546011)(2906002)(38070700005)(8676002)(66476007)(8936002)(4326008)(66446008)(66556008)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7Kh2479+E5b1NKCYIbIh9tysZPvdxN3m9oZeTpUGVkSjGfKC1RueF29yK5cD?=
 =?us-ascii?Q?bJ/v0viEAj0z8G+gSHoduFNKk3vuypJ1yGnLqgFnGefSAX75o/Y10//zWxZD?=
 =?us-ascii?Q?RRmRgijtD1VJl4RkdmMC1dMGrV7aYuNb3/BL0bZ0UZdWW5D+WwuZ8wRuBqjA?=
 =?us-ascii?Q?L/z7BtXVs4IEXsmh09qcMxYhUADUGVVBdg5awagF5QxSoqvybiGE5EoPRW3z?=
 =?us-ascii?Q?znQwyEhJw5YGJZvhoq05LKJWB1sk9JONb2c9zo0TejaIVJpZsTA0fOTP9ZnU?=
 =?us-ascii?Q?uzNE5tCzvfA0EgMpK7WktBG+NFtyqwiOUDv0rGrgUkhKOniUQDFDuHrb0RwY?=
 =?us-ascii?Q?pc2Dd8NfbW2N1rNH9pjuZNf9Y/dkdXu1nAhNfq4QZx5mwSQxyzDIRTqgW5iq?=
 =?us-ascii?Q?gnpflyQ2talYA/80+e1YW2Wz9I1I5yAgi0OKYSpRZQn+MPDRJM6232q6JQAb?=
 =?us-ascii?Q?BtqegBEr+aPktCPRescxmShOSRXWByiETWVsNkJdaF+me1lZYcWqENmPiV4j?=
 =?us-ascii?Q?W6YnmClzbBIevv7JtErcR0oydy5SO7z34BR6DnwwvR02PU1DP5oKJAueEZnv?=
 =?us-ascii?Q?KBtBNObV5cm0UTSveOEdeUrWLznwQA12bZZ33vmBcqLpBWY2ZdRlkjq1NJXz?=
 =?us-ascii?Q?kSMYR+NxOVy/p0sPNDfPMhCHqpcUFbrQYk/t47Xx2Rck8djJwJTYOBKx8sho?=
 =?us-ascii?Q?lVKNWPLlgDGX1mhqsxJ+c2PTMBarbUMvHHOCV8ntkJfYR47MzZdXT6PPF2xa?=
 =?us-ascii?Q?MSIigp5z1972+iEYW60Zas+i/e/l+hIMBahlc/jjn4ukklN96/1MfNnzmGQd?=
 =?us-ascii?Q?CGR6RX2L9RQEwYEFacLSc3Xj/d/yG34cx0/EH9FRH8Wk52E3NqaezCGC27Y+?=
 =?us-ascii?Q?8i0IeO+oDL3xClbz5z1q2CIoc0YV+r0o5NzhEwMUOdmXEg0KV8+WmtSxr4Yu?=
 =?us-ascii?Q?gAK+DdQ9ThZQOK+29CvTqXadCof4D8/iYVjZ/bIMCKdr1liKD3yhZ3L9+9pv?=
 =?us-ascii?Q?pyIco53VJsGGbhqOS91EeCNVMPpS+mKdCKQGHEuKobpYu47iZC2c67kZJ87D?=
 =?us-ascii?Q?Wk/ptM4+PCwBWE4aQuKSWeydUOVTNmsGagqM/5ENeK9WPs7p8ddKarwLaziH?=
 =?us-ascii?Q?e8WD2tAmCZEolSqbRsWTkhNQLX6IL5b+7ToesX69u+UBdV74FLa/vyjQ9QyM?=
 =?us-ascii?Q?ikZKo3aqBOnKiae9TH/hemkucwl4tlRKTuxuHmvyqPXpLkqJhd+5gsGj7ohg?=
 =?us-ascii?Q?+EIMP6b+/+lkxiW31ZANSS/vliiy7ZA4lhcdFDbEmP15lrmTa3KgqbcwuAdj?=
 =?us-ascii?Q?0UMJ6hMm1FDcpdUlUUrkAv4UwRQtqO40CIShB7TlnFDv4AMCD979jc/FskoE?=
 =?us-ascii?Q?wEmSioHi9oFcjUL2PsmgyTZiajQ2MMWSh4Ef4e+URQ0XRwcUN9ysTw91Rd5f?=
 =?us-ascii?Q?V+mFANbfdV0EeGakBDt8DUochRAXiGWA+gt1q2wrI3RM/LYdWPUvDdoaSSAJ?=
 =?us-ascii?Q?CTQJkWu1bkmGfnxrANPyAJt+KZr3cfQ9fgYVYtUwQ4yaX359j00OKpdqGR7u?=
 =?us-ascii?Q?6B0DVfYp2cqWKCrM8oHSz3If3uXoU1DBvq20Rjvkx1TpO98EmR92ds7OBhyQ?=
 =?us-ascii?Q?qj6LLzN2+f+OhRosl5S+Pdg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <37B97F80E4FB3B4EA0021F037F61BCE9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff7452c-daca-4e78-6042-08d9f8845cb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 17:29:22.3878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y9As4LWiefqQjbm9+6bQvJ5FUAPAr6+ldNT/JgG5h0Xt/Eq7C1JiuiAWjzIvN7/x4Q+eJYNLHtWw/gucVlmpGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1910
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202250099
X-Proofpoint-ORIG-GUID: yiJJiPHcO9VJNOgGmg41wgSBUJuUdqfE
X-Proofpoint-GUID: yiJJiPHcO9VJNOgGmg41wgSBUJuUdqfE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 23, 2022, at 1:16 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Add nfs4_anylock_blocker to check if an expired client has any
> blockers.
>=20
> Update nfs4_get_client_reaplist to:
> . add discarded courtesy client; client marked with CLIENT_EXPIRED,
>   to reaplist.
> . detect if expired client still has state and no blockers then
>   transit it to courtesy client by setting CLIENT_COURTESY flag
>   and removing the client record.

Thanks for breaking up the v13 patch and adding these nice
patch descriptions !


> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/nfsd/nfs4state.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++=
+++--
> 1 file changed, 98 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 01c51adf4873..282b8f040540 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5821,24 +5821,120 @@ static void nfsd4_ssc_expire_umount(struct nfsd_=
net *nn)
> }
> #endif
>=20
> +static bool
> +nfs4_anylock_blocker(struct nfs4_client *clp)
> +{
> +	int i;
> +	struct nfs4_stateowner *so, *tmp;
> +	struct nfs4_lockowner *lo;
> +	struct nfs4_ol_stateid *stp;
> +	struct nfs4_file *nf;
> +	struct inode *ino;
> +	struct file_lock_context *ctx;
> +	struct file_lock *fl;
> +
> +	spin_lock(&clp->cl_lock);
> +	for (i =3D 0; i < OWNER_HASH_SIZE; i++) {
> +		/* scan each lock owner */
> +		list_for_each_entry_safe(so, tmp, &clp->cl_ownerstr_hashtbl[i],
> +				so_strhash) {

You're holding the cl_lock and not changing the hash bucket
list inside the loop, so list_for_each_entry() is sufficient
here. _safe is not needed.


> +			if (so->so_is_open_owner)
> +				continue;
> +
> +			/* scan lock states of this lock owner */
> +			lo =3D lockowner(so);
> +			list_for_each_entry(stp, &lo->lo_owner.so_stateids,
> +					st_perstateowner) {
> +				nf =3D stp->st_stid.sc_file;
> +				ino =3D nf->fi_inode;
> +				ctx =3D ino->i_flctx;
> +				if (!ctx)
> +					continue;
> +				/* check each lock belongs to this lock state */
> +				list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
> +					if (fl->fl_owner !=3D lo)
> +						continue;
> +					if (!list_empty(&fl->fl_blocked_requests)) {
> +						spin_unlock(&clp->cl_lock);
> +						return true;
> +					}
> +				}

IIUC fl_blocked_requests is internal to fs/locks.c, so this
little piece needs to be moved there. Jeff can give a little
more guidance on function naming, etc.


Have a look at Section 6 of Documentation/process/coding-style.rst
for some hints about what to do with long functions. This one is
long and indented far to the right: that is indication that it
should be broken into smaller helpers with names that make it
clear what each step does -- no comments needed.

So for legibility, "check each lock belongs..." is a function that
should be moved to fs/locks.c, as I mentioned above; and "scan lock
state" can be its own function that calls "check each lock belongs".

I'm not sure what the comment "check each lock belongs to this lock
state" means. I thought we were looking at blocked lists, not locks,
in this search?


> +			}
> +		}
> +	}
> +	spin_unlock(&clp->cl_lock);
> +	return false;
> +}
> +
> static void
> nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
> 				struct laundry_time *lt)
> {
> 	struct list_head *pos, *next;
> 	struct nfs4_client *clp;
> +	bool cour;
> +	struct list_head cslist;
>=20
> 	INIT_LIST_HEAD(reaplist);
> +	INIT_LIST_HEAD(&cslist);
> 	spin_lock(&nn->client_lock);
> 	list_for_each_safe(pos, next, &nn->client_lru) {
> 		clp =3D list_entry(pos, struct nfs4_client, cl_lru);
> 		if (!state_expired(lt, clp->cl_time))
> 			break;
> -		if (mark_client_expired_locked(clp))
> +
> +		/* client expired */
> +		if (!client_has_state(clp)) {
> +			if (mark_client_expired_locked(clp))
> +				continue;
> +			list_add(&clp->cl_lru, reaplist);
> +			continue;

The above looks like the same thing that is done below at
the "exp_client:" label. Should you replace this with

	if (!client_has_state(clp))
		goto exp_client;

?

Then I think the one-line comments would be unnecessary.
The code would be self-explanatory.


> +		}
> +
> +		/* expired client has state */
> +		if (test_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags))
> +			goto exp_client;
> +		cour =3D test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
> +		if (cour && ktime_get_boottime_seconds() >=3D
> +				(clp->cl_time + NFSD_COURTESY_CLIENT_TIMEOUT))
> +			goto exp_client;
> +		if (nfs4_anylock_blocker(clp)) {
> +			/* expired client has state and has blocker. */
> +exp_client:
> +			if (mark_client_expired_locked(clp))
> +				continue;
> +			list_add(&clp->cl_lru, reaplist);
> 			continue;
> -		list_add(&clp->cl_lru, reaplist);
> +		}
> +		/*
> +		 * Client expired and has state and has no blockers.
> +		 * If there is race condition with blockers, next time
> +		 * the laundromat runs it will catch it and expires
> +		 * the client.

This comment is still not clear. "Client expired ... it will catch
and expires the client." Do you mean "destroys the client" ?


> +		 */
> +		if (!cour) {
> +			set_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
> +			list_add(&clp->cl_cs_list, &cslist);
> +		}

cl_cs_lock is taken in the loop below, but don't you also need to
hold that lock when manipulating the courtesy state bits in the
code above?


> 	}
> 	spin_unlock(&nn->client_lock);
> +
> +	while (!list_empty(&cslist)) {
> +		clp =3D list_first_entry(&cslist, struct nfs4_client, cl_cs_list);
> +		list_del_init(&clp->cl_cs_list);
> +		spin_lock(&clp->cl_cs_lock);
> +		/*
> +		 * Client might have re-connected. Make sure it's
> +		 * still in courtesy state before removing its record.
> +		 */
> +		if (test_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags) ||
> +			!test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
> +			spin_unlock(&clp->cl_cs_lock);
> +			continue;
> +		}
> +		spin_unlock(&clp->cl_cs_lock);
> +		nfsd4_client_record_remove(clp);
> +	}
> }
>=20
> static time64_t
> --=20
> 2.9.5
>=20

--
Chuck Lever



