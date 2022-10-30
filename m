Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E262612B31
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Oct 2022 16:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiJ3P0l (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 30 Oct 2022 11:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3P0k (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 30 Oct 2022 11:26:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73BDAE69;
        Sun, 30 Oct 2022 08:26:38 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29U7UJCG012040;
        Sun, 30 Oct 2022 15:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=vKkmfLCD4ebwT3O0m6USoABfAtr4ZkUL+4KcTd6CYOE=;
 b=jJLBVWK7X+acozZTZfDeFumaf2o1UZkNPARpt/Vv/sTGic3VEmkfUQo5XsgUbczH6HRc
 fyrWPYQ8QourwUXV96RqDLQhKZ5yZfH0CBHt+6Lv+HlclCxWcho2LOqEfm0bdbjSBgd0
 cbEvpbwqMe1F4+Op6tFt9TdCqc3nTqhXC3dwXoZaCh8BRAozYiF7D1LSgjCa8IWVKF7S
 PNYgsgPGx3kRaThQkp00/Y1o4PHypL2b9WaJG18olGC7p78ADDFn5FWKI2yeVCbXg2NJ
 QQZEiV0mRLuBx6YoRIYBzVlPSvCTB43ispopghdtxAe2qGOKRCb6h+LS51qEaBPCApjM 0Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgvqt9pua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Oct 2022 15:26:33 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29UE9AVj036031;
        Sun, 30 Oct 2022 15:26:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm8renh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Oct 2022 15:26:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+BfaPJKvdnM9aDAAyAPki+FUPoe/GjxqQrBcF5fEexPM2KrqcDxZ5XUpAAW9pkuo6WaPrzo99nI4GuQksWd+BwU+KfZKXo1ovbTdCPCCvPIvb6JxXkEXIL4qHu/pN0vVRoqPdGOuFqNKnRQsyf6bwUF7sukilt2c5xBnxSXUvosaD1q+zkmgQotrvqNgW8FXcQBRwIdfDYW5k6bmFiQ4F7Vic0khp9VWcrj4jtLzCxzTlE5TTfbvz/D6S+tjqaDAJEQAdTzXAfAVAV3h8yWzgvRhHAWWzTINTdduhy5CG7GVyPyigE/+rS7Hy6OCs9/HEBq5cHlo+CAxan1AAI+Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKkmfLCD4ebwT3O0m6USoABfAtr4ZkUL+4KcTd6CYOE=;
 b=LvUJF2hc7vm88J/yys0x/PCfHXpnlhbtyHExw3UFxiQkfD9fDnMeeev2uCH60/qK1fQMndwiqXscdd7qIOIY4FiF5Kyx+F20F1fd3RJQNraAOA/OqtJkgGa6cAkm9UwAQT1dpnNCyFUNWgAH6Dl5LznlXr+5EYzdo2OAiT+wiOPdfcBfmWXexpZXuPga2lN/4vDEYWC99NDv2Juu4xMc/XV7PZa40qyFWKCdO5Rb2yaDoEZLXc2FJzB55jRyHJaoL3StlmSutTqYBjf4lY15SZtM4Cgn4cu/EiZmfL3VtmSR0UjF0y1KDbhCp6LuFDu+CgCft7UThONbi28E6mP75w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKkmfLCD4ebwT3O0m6USoABfAtr4ZkUL+4KcTd6CYOE=;
 b=r2BdiTiwiy8V85FO5cIVJY7gZhqK3EOefqNFG4LQ02hOouk4+tBVs0P3mX6izoe2FqFgXL20mt9Zi03XspEJAa3vcdhQrWEONzRBU9vYLd5vfr0w/UBXJeLG6r/c2IgEIqFi+B9JLmrqbjqXefPdIkK0BwuHpmC/702AZkFopzE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5222.namprd10.prod.outlook.com (2603:10b6:408:114::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Sun, 30 Oct
 2022 15:26:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5769.016; Sun, 30 Oct 2022
 15:26:27 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dai Ngo <dai.ngo@oracle.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Bruce Fields <bfields@fieldses.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFSD: Fix the share reservation conflict to courteous
 server logic in nfs4_upgrade_open()
Thread-Topic: [PATCH] NFSD: Fix the share reservation conflict to courteous
 server logic in nfs4_upgrade_open()
Thread-Index: AQHY7DD5/V7HQv9STUORmP83olqFpa4nD5EA
Date:   Sun, 30 Oct 2022 15:26:27 +0000
Message-ID: <FB543B1D-A3BF-4403-9BFD-CE3AA40A89B5@oracle.com>
References: <7ed2d8f1ee8c441a13b450c5e5c50f13fae3a2b9.1667114760.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <7ed2d8f1ee8c441a13b450c5e5c50f13fae3a2b9.1667114760.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB5222:EE_
x-ms-office365-filtering-correlation-id: aaba3ab9-240e-4831-b00e-08daba8b1cfc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tHIgdw15zyXT7EdBhqoVpbquxPB1Y0yzh4APOX+PEzG3tBo+Mg13/14lFIOoo8eU3i+UoVFx9aLQoYtO4Xi8+esss/3pGX+JHMD9QB+VtClJJMG6K913LWyTZxqXhltM/PJ2X9Q1qJKhsqu5uVFWj/D4R7105X/q4FuzsYk5INiFJ3qRGEvlsViW5d2xWtnwtQT8Ir0JnUbwyblsGI91PhO33EXl/2vlIXfUksawbIrHFsBSdvfqUVua6MNaHxKLLTfC4xN3I1mU66wNqr1oMYRV3LOBNClqPcRS0bZctQNV/CDeJsuH0DXgmTvijXnQVO19XrqSg20ez6oT+oPeovnVpIGiisEOSPZm7HAMJoYADqTyjZqJdSqGpWWJD8kdnhwadgqPyL4nNPYXaLvppOPwmKM8r+Qvkg/Uoh1QlYUz43wBacjJOlqjcO2a5PfUKGSdNvjwktct4YozMYwgvOM4bObGjpOSlSxnCMZUbzIdGe2tMXT1nzozRcCTtijAX1OcldUcbMqiur0ZSeUCln6sMDOxOOCcwRP+KGghQ3DswB+G99NCracf8u1uUfKo6NN6UvSlM/TmkoT157BWOMHGtcdaCWzfx0IByZxC0BNEAX/aFfK6Es4kV2S0+deGVHKSDqgSUagLvhGgbBQ0AAtojsFRGU662ZGhkZyCX4s3P3HVx7/EBfFkz1PJvKxDsmzvGFI7argHvdrAdiJieRNleJ8IhOCa/wN21Hy1jsD8C2jWA87o+CWWmCcYEMKNm4+S1ZUUYHoWs1Pu7QgH0pgGOf6Exz6LjpYPv8mXDfM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199015)(38070700005)(86362001)(36756003)(122000001)(38100700002)(33656002)(2906002)(71200400001)(6486002)(478600001)(76116006)(316002)(91956017)(4326008)(66946007)(66556008)(66476007)(64756008)(8676002)(66446008)(8936002)(5660300002)(110136005)(6636002)(54906003)(41300700001)(6506007)(186003)(2616005)(53546011)(6512007)(26005)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9ffrjn71NqQVzB2f9DUzqZd79Rk4gMR+4hTLCc30/m/vIG7VUOgp4zysNsaJ?=
 =?us-ascii?Q?z/kGZ4Vz+YRW9n+SyE1juv6jpFmrHYZ8NS5sytDL4TOy3YgE6oogCO6z6KVm?=
 =?us-ascii?Q?N5V3CBaetfmqIRSmARi2NpeERw282pMJFJ8BpvqU51kWMlaEfTOPo03RVMkq?=
 =?us-ascii?Q?KpCHvNlR3DiSZzASoGR7Ka/93zgAsMu5kSdTuuE8twIydMAiyVqyStw43IvH?=
 =?us-ascii?Q?SaBtLdcx+rX+mtpXp4ks1548g4gfMsSwgYVcEcg/sNPlKhaYp3TLifHaMHac?=
 =?us-ascii?Q?YgH3OGdR9g/1YjcFDpRs6P5QqFk0wGZjHgw9E620nZm14H7/HNmyTMJ2WuvX?=
 =?us-ascii?Q?N/n87Z5B64XroKx1x/rZeGt0hZl0xyzHZ6ObiS2HA9l5Pss6CiXEIDHcgHF/?=
 =?us-ascii?Q?pMQnMnh0N1SUUNyCia7bezhwQS611HCTxUGo5uSQtUQ5/lZAZMqv31gj9EP9?=
 =?us-ascii?Q?xo1BqB5A+Yxn0QmBJKJ4Ro84iiBK6fY7yxrIF7J+M7Rnp9JnP+0+hjwKP+t3?=
 =?us-ascii?Q?soP8icXHhOqOybGR/um+U73scHdrS+cqsPNT/WSfbccjQqcQ4DWZ2vP5Y6JH?=
 =?us-ascii?Q?6QRrKjYWanOebwbcnQel0x4SdztSkZ1YSqUvjI6j3MwgzrwJHeXC0oAK8+x0?=
 =?us-ascii?Q?NYNKreI9Sapnc6jsOd6oThJ9lHsltUq4OTzY0XbQ1U6w2jp8eVbOgxEIiSvJ?=
 =?us-ascii?Q?KWZmPWLEEhdpiR9kAptTvOIhtS1GByPy6Msh3ntoVOTGubJIzDXz5bfmq9HJ?=
 =?us-ascii?Q?9aw75sHDwkrfIneXrRM6LF1/0wp0hG2ieQU8gNC6Y6ZGsadQVj0DFLVRVOlx?=
 =?us-ascii?Q?5IwjHqk5McgvS++qJyVwawAhPGS4iM6p/teNn3U4qM1R2QiL6itAP95QbfGr?=
 =?us-ascii?Q?2XMNsmydyK2W8ociKfyleJaTZ903VDmAHI0CuQkzybwT2R6G4hu79lm+hwO3?=
 =?us-ascii?Q?iaPUp+fgv2CkR9l4VGW+K+HlRsx9rikCDVrYr3+oLDpqhxwnIejzucTFJW7x?=
 =?us-ascii?Q?/zSPV6Mzd+w7FdpSghGXOlxBC5c4V4pANTAM3jSU1SHUdv40CwT7JnjeBgrM?=
 =?us-ascii?Q?A1bRx5/juJ597vZoXI414oR4EgWj1gXTYW4sU/d/QSyViVBud6KTDn3KWmrv?=
 =?us-ascii?Q?k0KH6zpZVr4aHWXnyHhaBVD/Ge0nAOhY6BQ0QYqj+P2fpdmBn599Jt7+EFJK?=
 =?us-ascii?Q?3DTFHC9hnVlXsFAB/c29oSuqfDiIv3yfl1xYB7XdDL+opbCYIf0wtJa3/UkC?=
 =?us-ascii?Q?xh8nCyq5eMAtsA4wRdUGpGRRKc+t9Kb43zAOScTvYkgnYftVB8E0PDFlsotL?=
 =?us-ascii?Q?RjEuNAlZaRKM//CnjvRFzHaVdogTJ+j0E2Q5MZrkByQNmjSZ4+9Mwpi/gvSu?=
 =?us-ascii?Q?drolcrLgC13hp9Nk/pU2uKbCDgAliFV23NqB5GbtQ1JlgWavK13XbMlgITOG?=
 =?us-ascii?Q?jKKy6ZnWiHiQzK7KnBoUR1VnfiZqbwA0Y/2dj9k/P5orl/TT7SJk3mIU7fQ2?=
 =?us-ascii?Q?S2LST/tJF+SUhR8ySuMQdmTzaJwEqpF7LABzeh/h+b0R3OXCk1yo0CEFr9ZJ?=
 =?us-ascii?Q?paUUM9Xrgtx86T+7QaJ9wjO5/GklNt5KbREdZagDzHgipGhfN/jTjeEyjcIB?=
 =?us-ascii?Q?5g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3A7DE69FB9EB994CA233BFBD95C6EC0C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaba3ab9-240e-4831-b00e-08daba8b1cfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2022 15:26:27.5419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: grHtFb+Cc/tGrhgtDan9WdvDtoCQU5eXk77CKbCjDqLCWBrOBrWp+YMbprcPxp9KeR391knBCRn4De2Vjc92Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5222
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-30_08,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210300101
X-Proofpoint-GUID: uxK0ODfw2rxdeh8oeOHelm8NIKI0M0FR
X-Proofpoint-ORIG-GUID: uxK0ODfw2rxdeh8oeOHelm8NIKI0M0FR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 30, 2022, at 3:26 AM, Christophe JAILLET <christophe.jaillet@wanad=
oo.fr> wrote:
>=20
> 'status !=3D nfserr_share_denied' is known to be true because we test
> 'status =3D=3D nfs_ok' the line just above.
>=20
> So nfs4_resolve_deny_conflicts_locked() can never be called.
>=20
> Fix the logic and avoid the dead code.
>=20
> Fixes: 3d6942715180 ("NFSD: add support for share reservation conflict to=
 courteous server")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is speculative.
> It is compile tested only.
>=20
> REVIEW WITH CARE.
> ---
> fs/nfsd/nfs4state.c | 14 ++++++--------
> 1 file changed, 6 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 1ded89235111..de0565e9485c 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5260,15 +5260,13 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct =
nfs4_file *fp,
> 	spin_lock(&fp->fi_lock);
> 	status =3D nfs4_file_check_deny(fp, open->op_share_deny);

I agree there's dead code here. I believe the bug is the first check is
supposed to be "if (status !=3D nfs_ok)". I will let Dai have a look at
this to confirm.

But, in the fix, let's replace this logic with "switch (status) { }".


> 	if (status =3D=3D nfs_ok) {
> -		if (status !=3D nfserr_share_denied) {
> -			set_deny(open->op_share_deny, stp);
> -			fp->fi_share_deny |=3D
> +		set_deny(open->op_share_deny, stp);
> +		fp->fi_share_deny |=3D
> 				(open->op_share_deny & NFS4_SHARE_DENY_BOTH);
> -		} else {
> -			if (nfs4_resolve_deny_conflicts_locked(fp, false,
> -					stp, open->op_share_deny, false))
> -				status =3D nfserr_jukebox;
> -		}
> +	} else if (status =3D=3D nfserr_share_denied) {
> +		if (nfs4_resolve_deny_conflicts_locked(fp, false, stp,
> +				open->op_share_deny, false))
> +			status =3D nfserr_jukebox;
> 	}
> 	spin_unlock(&fp->fi_lock);
>=20
> --=20
> 2.34.1
>=20

--
Chuck Lever



