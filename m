Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828F04C7028
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 15:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbiB1O5Y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Feb 2022 09:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiB1O5X (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Feb 2022 09:57:23 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27497F6EB
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 06:56:44 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21SDBJsl021511;
        Mon, 28 Feb 2022 14:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8bEsiQ0UIoz3bG74rghvqrmnO+cy0sc8tAZH9FQbLcc=;
 b=u2xemaDq04f3bLvxFPoYE8XJT5S3SLhvgzZ3q5v7jA2DgGKOksqEaoq+LemzoPm1P5j6
 82T1cL2NWywZs6NhPBtZcGBFc19Foqz5xybZiz7OBwYaHl3xEdE6VNXPan4PLS4Z7aie
 60H+N0QwNvFiP6ppfmsN1hSQKFHR9R3WoSpSWGNYXwjDYakJ5sjTEGKzw0IS7wGW1LYi
 BEKGQfSoC2pW8JJ8Q+ShIvBqF/y6IMM18fED4t19npJLXjCNfd/45vkfqCsc2GULZNZ7
 aAqXBlG85sPLXfyL/jTdRsVAAup/VQetN8f0tziVtnJtNa+pC4ta+BiE98vJ9JCojkz+ qQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3efat1vf9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 14:56:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21SEpGC3022149;
        Mon, 28 Feb 2022 14:56:41 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by aserp3030.oracle.com with ESMTP id 3efa8cm3gr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 14:56:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bi9YEpZ24n0vovdhSGvx3WBa1oLTHqPa9cbEjPkDAWqWKSu1Q5fiRICev0uXGzsj6W126XCh6LYJLjoQhp8WLCZO11ZZ5XZQPodhrnbce3e5IQUM5eMxZfne57jJShx/BxJwPHgVYGYh1leAUPfv04GJoNHErN7rAHraSSF3zw3ITuXVOVcAuVAGBls1hKbvQsQGfF84HASD8YJHukkcEex0t8PuIGsjMaops1MmJCZE+RXX49yf+1FXd5S0c3X5KvUpJpZt55k7EjTiIK2/e6HeVPSf6z+SM49/JjvQjTGS8Hc7ze/o3gHxbdRrw8GIaBkQiHb8tpv00ksaH+RZPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bEsiQ0UIoz3bG74rghvqrmnO+cy0sc8tAZH9FQbLcc=;
 b=YdEgc3Wk4qWOdOQ5t7BvIFal4McY3KuuTlKmQvSNpVi5bqhqOiL7anwwGhWiScoB//vMcflXWu6NACdawFrJoaCrSKCHyR3Lvxd+591wTg1wHGl9AvqZnATi0Yqgu4rGQ5/048HnZuvsuQJG8iKD5v7zU1OwBpedOlZQYBIZ5GkzZLJLESO67E1MVMQtbfZ9/VZCs+GkFmz2/FX0d/gWvU5v+B7ZtBoAswVBxmgMzQogslFFxuBEaAMorsirhStQN40c5SR8LHbdnbNoIBAeTFV3mr81fV8tO+Rar+xgGuGvS5cvy4T7B53WKVAP5O7POhj3hz/MV1Q93Cx+8VBmyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bEsiQ0UIoz3bG74rghvqrmnO+cy0sc8tAZH9FQbLcc=;
 b=o4B0/0bJasONRP3ZMOxvW27Lc/zwv1IkuIYZIiGWMOAeB1THU4PRlwyggwGQUSmYa9XIN5kxXgW5bBUqR+8K5BlX0v+Sgpb/QENmrRITBFLHpT342ddFCE8PLQ9UV2kC8pOM9kK7mhkYabbphztCCjE5cFhukUJuRDE6kF4lUsA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5611.namprd10.prod.outlook.com (2603:10b6:510:f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Mon, 28 Feb
 2022 14:56:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%9]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 14:56:39 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC v14 05/10] NFSD: Update find_clp_in_name_tree() to
 handle courtesy clients
Thread-Topic: [PATCH RFC v14 05/10] NFSD: Update find_clp_in_name_tree() to
 handle courtesy clients
Thread-Index: AQHYKOGEpkcawtk6gkeNSAPS/APVS6ypFQMA
Date:   Mon, 28 Feb 2022 14:56:39 +0000
Message-ID: <448E3513-197B-4988-AF27-B691B6696F5E@oracle.com>
References: <1645640197-1725-1-git-send-email-dai.ngo@oracle.com>
 <1645640197-1725-6-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1645640197-1725-6-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07793550-9bdd-46b3-e7b4-08d9faca8653
x-ms-traffictypediagnostic: PH0PR10MB5611:EE_
x-microsoft-antispam-prvs: <PH0PR10MB561161FA10C7C424456DB18B93019@PH0PR10MB5611.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WQbXalY0e8x8ojdCFwmyuhwJx6IwiLGIrm82Da7mYyraCyYYR0HyzW/UzQNVxLo3YpJL/pC/IlY22xNVbgzll3X6VOIQuF4IhY06P1LE+lKoYPsnzMz+iglPkhBt9Tnwym0PR/VL1HICOCjrlocWiVbVUDz6ADa/5vgtpuyHVk/JMjLPvzqC+y8u6Kg8L6C6zRuxZZm5jj97FkBh0gd+0XDFWhth7F1k5kjn/3h7GIf5vDmaWSuuDZef1RjV6WHTMlXTTw1BPx2+VLNvqoVTyCB/SIvmeE3w9A1e8aI5oArzHTXGcsFsYe1KCfV69afYpLsT1MUadEhD9jHWHiyprOD+mEvQQna/gvq352JiCvljKtkoVUB/JczonsFoO37a8sdmUsx00IZ+YyCicv6VWFOkoiPIilg7UjKSwhhZU763ZReNToxeaD+AZ56WOo/KneMrjQrFaZ7KIlDZs9sG6vzd9R4LegrRZ9cR1e6kI3NpsnRxnCKVBwdeB1KtFDc75gBaI7tPt/pvd4+vBdzJlzTxzqka4qdpwKz5yTPMS9zpbljn0ZgInRPMIQp3pC/vyBQrYcXERWDvBbnFDxLlxKdsT4+pp9A/BYleX9bVswnTWsTFzjtSYD+n2PE9kBzGiGJ2EFo/j/1tjvsSh1rCr84ebTqUJJhtZB2IVn2QXZvV4TCGRz/Lrva7cpaWcdnkSRP88HIHU5dbTK512nt5hrcYhnw6fDigyF4ReVJN9EJaASPfc+2UNsRgK8w/R9xy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(4326008)(38070700005)(83380400001)(8936002)(2906002)(15650500001)(5660300002)(33656002)(36756003)(6636002)(71200400001)(66946007)(6506007)(316002)(26005)(66556008)(91956017)(66446008)(53546011)(186003)(66476007)(64756008)(2616005)(8676002)(6862004)(122000001)(38100700002)(76116006)(54906003)(508600001)(6486002)(86362001)(37006003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PhRwE+BliUdvUaqcQtGrIMx4m+z8RC0r7pYMYVGDIzz1yEoQx3HtRSowcMVu?=
 =?us-ascii?Q?M+GPGKvvKGTnQB1toqu+BA9IUgRElQuzhW8whuuSlm14H+ZHQVBXlICiC1yZ?=
 =?us-ascii?Q?tws8wSYA12wAdrmDcGS5GITiqxioBZxF5NhfuZp2Ca793Mt1LCxczrP74R+f?=
 =?us-ascii?Q?OrKsQQY5vCovVZqE3IHuuZX/IPVDmRXwD2CfahTJa3fg3v0oz65pKk5Skm7i?=
 =?us-ascii?Q?X4MzBi1bag1M/dtpOSQ/JE2raGKWrhDyG09YTw7xI4Cd3WvsJVHXGLnH2qKV?=
 =?us-ascii?Q?NyaA8LPmzKBtguKCarB34oVvKke3tq/p82QDlK6BFLtHwS6alEJaf9hGrxRO?=
 =?us-ascii?Q?Cl+sgXfcAw19Cg+N9iVYLI5I2cwPJL7s2hvQFbg1KUkjBklmNkZji8ibqp6g?=
 =?us-ascii?Q?HpR6B+uFSHiAqvcuAvBOtiicRIAunolkk2286n/SAp+3bqPGpPVTv4LjnGR7?=
 =?us-ascii?Q?EiGyGKDoLlJVyukQSQlaWsVclJtEoGKMlxm6TLoPbrK62vggBD+XowiTaW2s?=
 =?us-ascii?Q?EPGjQIX/tVlKz2YAnm0boVBqtVtOOjxZItU8q7Ewuwpm5AozP4wJKc/D9HvV?=
 =?us-ascii?Q?AEkIkKmV5AYSSdLRTXboTDUkAYjDYK4pgD/RHTh0xFz2u0JIuSeywd17bg8u?=
 =?us-ascii?Q?beThTxDkg1CKjZ2Rhk9mSvTjY4Jvela1A3iKQpwxMScYt/x24lA3idi+/Rl8?=
 =?us-ascii?Q?APqE2xq+pvNrgM3D4LNVnbMvveN4Zahb4T/6kuWs0qkqtNpRoKjbYMLOHhYm?=
 =?us-ascii?Q?HpsMgM5ETLykdtSs3BMSpAbY+u1FJeZAalVJdu73RuEkK8XwSb5q+14PJP2q?=
 =?us-ascii?Q?32gbdssVQ1HSFUMmhVrVXcr2XczcO/w2mkzsP6nlj82tKriJtYRZz5mLPWef?=
 =?us-ascii?Q?EJ1ekLwoluA3m9MWU2Ap3wXyw0p5aj7P2UMvz8YWP2drOkciXSqgWL/Jwbaw?=
 =?us-ascii?Q?CIJFakMpF7P8arD+hxN1GglrVEUEGyZkl+5mEqoSZZYf1oofXLcW4nMhrFim?=
 =?us-ascii?Q?6/I2uPXoXl6+0fMbfXGNrW4Jzzn9V/DqmXt4WzKAikSoESQVGX9UxHeBM8ss?=
 =?us-ascii?Q?1brwX+M7qRPbwtI0Uc6aIAeM6kbcaEaBtCLW0jrgfd4hfjWemKWWomUipn6c?=
 =?us-ascii?Q?i9fFSk4a11KD+rcDm+JVe36ozW6B8iR+ZxdEtABLiuIHxnAWmq3PUMj2/y9J?=
 =?us-ascii?Q?aEllKrb4DhrqXoYU8ZZQMRH0B3WUO1oXnsv/+IKoiNta7l+X0C1BReZbVt/a?=
 =?us-ascii?Q?CyR3M8Y744EKWMBxrcALhO+w7HXwelCNiP/+HW5XzUhWmm1+cbxRmsYkEzHS?=
 =?us-ascii?Q?fT/C4/v2Pez/9b1dTQUEteDZYYfJKGD9DT6EmP3NEQCjIXkRl6iSw2SPxPTt?=
 =?us-ascii?Q?pojivHriB4g0o+1St3xQHEGAb/VX1d78dt9QsEYTeltCnCoR2AOYMECob+bQ?=
 =?us-ascii?Q?aPuIyQ8L8KRJMYuWcPU0n6Y3RZ7hDWmhG+JWb++jU6O+rZ6MjNg3+1xvqTLy?=
 =?us-ascii?Q?lZnxUosglX0wtLmQO9lzFsPnmjrScjfXAGj7r8U/rpc88G9e1q5w/ZOnvgad?=
 =?us-ascii?Q?RG7lYKUegWbksSY+WyEvZcFl4y8KeXoNc2EPwsA5bdRtLe6Pe38a5Pg8mLZi?=
 =?us-ascii?Q?xcnztfURVrYqioBdoNxl3v4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B2F564F8FABF8A41B43FB6AD59D16C05@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07793550-9bdd-46b3-e7b4-08d9faca8653
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 14:56:39.2525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YhoLor/Y9FKOVG7kqN+rME4EQwEVtgVbHT/scoWrKH6h3vWQkSFADy220th4uafkErVAJY+1Y28QTmoTy3TbRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5611
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10271 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202280079
X-Proofpoint-GUID: 2u3x_-1957XdANS7L0t9RVtk5gXAvfwT
X-Proofpoint-ORIG-GUID: 2u3x_-1957XdANS7L0t9RVtk5gXAvfwT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Good morning, Dai!


> On Feb 23, 2022, at 1:16 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Update find_clp_in_name_tree:
> . skip client with CLIENT_EXPIRED flag; discarded courtesy client.
> . if courtesy client was found then clear CLIENT_COURTESY and
>   set CLIENT_RECONNECTED so callers can take appropriate action.
>=20
> Update find_confirmed_client_by_name to discard the courtesy
> client; set CLIENT_EXPIRED.
>=20
> Update nfsd4_setclientid to expire the confirmed courtesy client
> to prevent multiple confirmed clients with the same name on the
> the conf_id_hashtbl list.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/nfsd/nfs4state.c | 45 ++++++++++++++++++++++++++++++++++++++++++---
> 1 file changed, 42 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 1ffe7bafe90b..4990553180f8 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2834,8 +2834,21 @@ find_clp_in_name_tree(struct xdr_netobj *name, str=
uct rb_root *root)
> 			node =3D node->rb_left;
> 		else if (cmp < 0)
> 			node =3D node->rb_right;
> -		else
> +		else {
> +			clear_bit(NFSD4_CLIENT_RECONNECTED, &clp->cl_flags);
> +			/* sync with thread resolving lock/deleg conflict */
> +			spin_lock(&clp->cl_cs_lock);
> +			if (test_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags)) {
> +				spin_unlock(&clp->cl_cs_lock);
> +				return NULL;
> +			}
> +			if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
> +				clear_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
> +				set_bit(NFSD4_CLIENT_RECONNECTED, &clp->cl_flags);
> +			}

This should be written

	if (test_and_clear_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags))
		set_bit(NFSD4_CLIENT_RECONNECTED, &clp->cl_flags);


> +			spin_unlock(&clp->cl_cs_lock);
> 			return clp;
> +		}

And since this is the same logic that is used in 6/10 and 7/10,
please refactor this into a separate function and call it from
the find_yada_ functions as we discussed previously. Thanks!


> 	}
> 	return NULL;
> }
> @@ -2888,6 +2901,14 @@ find_client_in_id_table(struct list_head *tbl, cli=
entid_t *clid, bool sessions)
> 	return NULL;
> }
>=20
> +static void
> +nfsd4_discard_courtesy_clnt(struct nfs4_client *clp)
> +{
> +	spin_lock(&clp->cl_cs_lock);
> +	set_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags);
> +	spin_unlock(&clp->cl_cs_lock);
> +}
> +
> static struct nfs4_client *
> find_confirmed_client(clientid_t *clid, bool sessions, struct nfsd_net *n=
n)
> {
> @@ -2914,8 +2935,15 @@ static bool clp_used_exchangeid(struct nfs4_client=
 *clp)
> static struct nfs4_client *
> find_confirmed_client_by_name(struct xdr_netobj *name, struct nfsd_net *n=
n)
> {
> +	struct nfs4_client *clp;
> +
> 	lockdep_assert_held(&nn->client_lock);
> -	return find_clp_in_name_tree(name, &nn->conf_name_tree);
> +	clp =3D find_clp_in_name_tree(name, &nn->conf_name_tree);
> +	if (clp && test_bit(NFSD4_CLIENT_RECONNECTED, &clp->cl_flags)) {
> +		nfsd4_discard_courtesy_clnt(clp);
> +		clp =3D NULL;
> +	}
> +	return clp;
> }
>=20
> static struct nfs4_client *
> @@ -4032,12 +4060,19 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct =
nfsd4_compound_state *cstate,
> 	struct nfs4_client	*unconf =3D NULL;
> 	__be32 			status;
> 	struct nfsd_net		*nn =3D net_generic(SVC_NET(rqstp), nfsd_net_id);
> +	struct nfs4_client	*cclient =3D NULL;
>=20
> 	new =3D create_client(clname, rqstp, &clverifier);
> 	if (new =3D=3D NULL)
> 		return nfserr_jukebox;
> 	spin_lock(&nn->client_lock);
> -	conf =3D find_confirmed_client_by_name(&clname, nn);
> +	/* find confirmed client by name */
> +	conf =3D find_clp_in_name_tree(&clname, &nn->conf_name_tree);
> +	if (conf && test_bit(NFSD4_CLIENT_RECONNECTED, &conf->cl_flags)) {
> +		cclient =3D conf;
> +		conf =3D NULL;
> +	}
> +
> 	if (conf && client_has_state(conf)) {
> 		status =3D nfserr_clid_inuse;
> 		if (clp_used_exchangeid(conf))
> @@ -4068,7 +4103,11 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct n=
fsd4_compound_state *cstate,
> 	new =3D NULL;
> 	status =3D nfs_ok;
> out:
> +	if (cclient)
> +		unhash_client_locked(cclient);
> 	spin_unlock(&nn->client_lock);
> +	if (cclient)
> +		expire_client(cclient);
> 	if (new)
> 		free_client(new);
> 	if (unconf) {
> --=20
> 2.9.5
>=20

--
Chuck Lever



