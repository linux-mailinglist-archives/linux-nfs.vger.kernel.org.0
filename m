Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D6962DE8A
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Nov 2022 15:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239263AbiKQOpV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Nov 2022 09:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239766AbiKQOpF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Nov 2022 09:45:05 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C628B53
        for <linux-nfs@vger.kernel.org>; Thu, 17 Nov 2022 06:45:03 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHE3uwV029814;
        Thu, 17 Nov 2022 14:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=mOiy+WQeY1yPVUKtwG4XRY/e65qEK2XwSZxy2a2R5Qc=;
 b=TBoTJT4117wn2MJ/Ab6ZXyXIdroSLM1ptvHv3rS2Ln5Coc6vZJLXzWGYnAa8GMieNLna
 uaoPtHXscn/bfniInUR1NDIwZ0datZAtNDcLPQQ2sbrcQwHLw36iPCLbp0T7OMpOBb7x
 8T0DhDs8N8WK/DtHSYAQ8TJLJei8+tXJoXUn7cOVCDa/Ep0Z3v0dKrbOGNZJR7dzRbRH
 yq1GHBPVx32M/PgV8o4HfjXdzZlnBOtDd5bbbAgaQcoXIeExZZgGtQoQdMvqBh8l52x+
 iWMET+rrWxya/ideTGqoJKpfm7GLmuLNAbopOSeFYn3+07ZkIyf/KCtuy104Es6fZ1zE 6A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3n19mgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 14:44:52 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AHEBNcY010847;
        Thu, 17 Nov 2022 14:44:52 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ku3ka0npd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 14:44:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDCMHctDY9UxtlQt+A4NJPLWULsBGcvU6nHTT6NgwpMbtt0jmBOviGAhQgotp7594KpAslm6j2YY48MHBFUWJccMyNTUVay2BJkolNNquSYmiXSL3ig8Ox2DpplG15K9QphJ3WwPGGNKcVXThxBh2TcUCL87ReSCqLOGcHEFiv9eGB5ttx1ksVNTSoFbGsdFEP7eYyuBMH+qhh4kvMbLYOlcXRkDLamwf9RLG+YpiLR79xgAZGbkgVB7boMh1AYNAVBxBxgb6SfOS/baixAa1R1KO8hNhEVwZOmGNZ3ymgQkBSggSnWLxAema2wLSCuGRcjR3m395mFmqISTf1OYpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOiy+WQeY1yPVUKtwG4XRY/e65qEK2XwSZxy2a2R5Qc=;
 b=O4ZOngseBx6CPmj2AG5G3hnHitlJ74SrpqN9uhKSnYu08guuQf+N5Ji6D3uPhi2F99f5VL/aT4x7CjXWGb1MCGCB6XMga4tqtAmT0goHhr+6fkiPVIxrzh+oZSQfJZU6YmJ+uUnTR5Xw36MZWcDpVbZacEFQlWoAHaS0Fj6fAxcKSeEGVgX6WYSt97fuytBWkIhHwq1QNM7hkphtm97pzguB7Q5pXz8D9yaFRt5VSalFHArslewIiLf3B7u3A6ehULrTkrcBvY/jQoysYhljr812ngnwazCCPOKdTakPAe87hSnF7d12OlffGGQGShcZd5KP1I27PODZnZOaDEMvBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOiy+WQeY1yPVUKtwG4XRY/e65qEK2XwSZxy2a2R5Qc=;
 b=Dc7lMfG1chHH2xYq8SMSQE/+tOQHj6VddfQR1PwRv9zypOe68edMkxI9Uuf8nDQVbB1o1IYfnw4okvuQm1yEF1/XTe25cY6ZL1M17Kje/SDCFqgSOF7tMW7F/Nkw4VoY4lHvLZSbK7NgeKayornG92FjR21EwmPbPYJwsjpi4Bw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4426.namprd10.prod.outlook.com (2603:10b6:806:117::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Thu, 17 Nov
 2022 14:44:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%5]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 14:44:49 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     "jlayton@kernel.org" <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v5 0/4] add support for CB_RECALL_ANY and the delegation
 reaper
Thread-Topic: [PATCH v5 0/4] add support for CB_RECALL_ANY and the delegation
 reaper
Thread-Index: AQHY+jb3b6PpTwE2G0+HfmxJhBZEiK5DMdoA
Date:   Thu, 17 Nov 2022 14:44:49 +0000
Message-ID: <8517F18C-9207-4DE4-A217-2A0EA4C4484C@oracle.com>
References: <1668656688-22507-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1668656688-22507-1-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA2PR10MB4426:EE_
x-ms-office365-filtering-correlation-id: 9a626201-412f-43b9-fdc4-08dac8aa4766
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MnPcDH6CoZASN2Qd1mcecv9P+f1MI0Id+95l+4BqGPvkzOOtLCX3fzjlN1Bf3qu7g0oTNy+7Seg9rclnFqoN4Wd+E3b1833uz5tyyEJEks8usH0ItxBixVxNwZKA/RJH4CAaS8jEhCzXotvCGJVpsPmeO0YotX/5c4Dz7BGdAOt/VfqBUYfAO+PghxubMuzkQ498vYc4oq4QVaGlpvpETW8Lsdu7M4icTvugSq9WoboL9cHFqtbShX9VC76KyhuLMqCFx7lXFLMB8XxBxikrSKUDTt7UN9tPtojsTGihXrDBVoCsbqglaxE1NKe0EGjnWUgj4qxvKy5zxy3AKENSPJRwaFgA8P4CnilK4obpEkPAu4WQYHku1pIy4kcdDiPMo40bypVa9+tTqcr6WxnDjqAGltU19FS+jMIkN6PoS3oyWO/9jenq9ue5b03UPn6bK2L3GqtYH9k2Ev4MYGxPWuN43w+1M6CPdbjYmTKWGJHW8BPdTObkfl1Lr3vzx2dXtIdnOlow2siXwgEWAugiAsjLbV10nOPnxRUb8JPDgGETnENOmullfPMaQXzagCWKWfMwggHKiWCpHwp4Rxotq6kiv8MIaCtXWJ3C1onW9gNFH86pp/lMOgHyMIYBgqsIN4aG4PAqd3Wgh90r4Wk90h7I/uZPzup4DhUMcChf9LIJL/dYil9EYCcEV2vfbWOYxAhil4Gn0nT3pU6ML+WPXxIbZZr0qbdZ/yNO+jRrHfk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199015)(2906002)(83380400001)(36756003)(33656002)(91956017)(41300700001)(2616005)(76116006)(86362001)(8936002)(38100700002)(6506007)(37006003)(54906003)(122000001)(53546011)(6636002)(6512007)(38070700005)(26005)(6862004)(186003)(5660300002)(8676002)(64756008)(66446008)(66476007)(4326008)(66946007)(66556008)(6486002)(316002)(71200400001)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9lxrMAOtr0evpyB4x68y6sFSt489m8WRtUW8BqOUQ4hwTRX8I5PWABfHzw61?=
 =?us-ascii?Q?j0UA1ZD+4HCd5ahVbj9cOdn4gdUPV9KxWJ8JeuNQ6E0UMBKVOKpgVy/6VqEX?=
 =?us-ascii?Q?em6k1AVGhxtL2yCSNVMptL54QloMRJW9WUArhvC26FbvXWVORFn/p5G1Qpea?=
 =?us-ascii?Q?ZZqiH1SwkI9eoTWkDYbyvReSETgSiMfpgzstaXQb93vSXoUPTZKy7CMyTj/d?=
 =?us-ascii?Q?C7YM4ol5YbhHUg8UNaayy/aQqUUoU3fMTbEP1rNfgB0dVVApwcPGxfnp5vvI?=
 =?us-ascii?Q?m4cm9GAQL1+kuucrbNSrbPB1JBIHeAwnmTYg54yTSSudE6RaucjQhmH6fAmW?=
 =?us-ascii?Q?RCzUtfo9Wz3Xm6kXACFRwpTtYkJCUQRwhaWodES4rvOyoB9c9eJSIWBZT36B?=
 =?us-ascii?Q?vtbClvj1MwpbJ2WRztpLz2kHOJb8jVFV8JHw3KngVaYWvEZp+/smaQYzR2lv?=
 =?us-ascii?Q?VKovlebC487KmCsm7FLeo3Mj4IE7UjmcokZTFGuX5+y2ubyWYNXM9NWfV0+x?=
 =?us-ascii?Q?IARiBKofziYpC/6MMYngpB/tSEPkXlNRJS0xsytFLhdl68VSZgIrPiqBE+6l?=
 =?us-ascii?Q?UqeqyrA+ng8BT0SdNc5poIVCXW8TrKl0SYhWFHJiV4CDq+9h2apY5KEDmcZW?=
 =?us-ascii?Q?6fz2KHNMKGXMRVTCXrDdbA1c07wYFH6z6h7pMzYMrezlcwyTmAOF4OCmDimR?=
 =?us-ascii?Q?/sd3INZ0PWZxE0Ve+TKcChIoX+jngjR0AcbAo+A0Nb47bocydZH/DbgCis16?=
 =?us-ascii?Q?+NjRSMcdGk2Hg+A/Cd+JC5bLHl/RuzYAtkZoRDARM6Kue9TF9QHBWPK5ZrOX?=
 =?us-ascii?Q?d3In8SuPhCpH6sq0on2Nf/fwwYTMTpD8D2vNsSbFF3fZDDD1DOcNbqJbnk3B?=
 =?us-ascii?Q?0l/L2muW5j0j6aEIhG7Il8lYlS17ufqTIuqE9UVFVhQfvoFCVrIki4c+FpUv?=
 =?us-ascii?Q?0R4PDPiB86uplvVkyV5zYuaYCWE8i9f9VT3uJhegR0F4XdVhttiCt85/lHUj?=
 =?us-ascii?Q?Vux3rCbJX2tAXHKWbqmLZiSfbSFC9LOX0NZflsyHE9Ba86QvZ9veYQcvQT7Z?=
 =?us-ascii?Q?beRI6z1EztsTUJl1og7sDFOeb70/GQfVPLjpbKlOSjqnPYLf+W53oNvsDCuK?=
 =?us-ascii?Q?swDrzCJQzYF4JCiapZ7WPRt4gxqphdIU71K/tp6rWsSadB8tGBcRPXhrBQSr?=
 =?us-ascii?Q?JrLJlaTZBXE97laVHHsGLVtKnjxfC+AWvDYP3ynoE5/o0E3RVbxpP+y0YYEM?=
 =?us-ascii?Q?NF7CMCJaSc6dYMtJGCuoFk2mRw/mb07WRUExnFZT7bc7HnUnxw4OEXxicXPf?=
 =?us-ascii?Q?c+gx0LvVR89upOM4cHidi4RFY5MIAfdOfk9HQ55dCf+mSqKy1Xn4DENPRIGI?=
 =?us-ascii?Q?+ZuizgkQWBQcJFUe/1MNLYB/p4auZN7uKiv7lFDy/vZGSgUl8ZCIUtAQX4Ls?=
 =?us-ascii?Q?gM/NnlxAAWDZd0f8Vxv4G4jkcwFZ9NAw/wQ/yXf1uMjBJtitR90jTirUU/Bw?=
 =?us-ascii?Q?hjWWfhh2xzuWWVJGyjhqEtL92RCN1u8TGszUX7ajJM82tNKBLt4x3UsXh8Jz?=
 =?us-ascii?Q?/bxX01/VHCqx4Ub7ZbhGILe1SoO5puYePASU1XnWImj6spwFggvOAztIAots?=
 =?us-ascii?Q?sQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A6321631B62B0C4AAEF619B9B073D2B2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zr/4fECuXKyM1iRqED3hdG1gTcrl4x8LtGOD1LVjrreuOHCf5x9FVE4nCpnvVXvTQ8yTYjNtviNR3w3Culbm7P1QILngixpfCc5pm3ktyjmRb8NHp7LYmByh084K1317S283iYX79D458SuQChTe5SQQBpd1zNhJpw/uAO+KwJ2hdHjr9qYdlSk3ZC3yoZDOW5c/lj5MFWpDJOitt+MP0IlMp33ln2F4l/M93yl1S5psMC/GEKUTYTuRfipaJpRIclTqTLB3tWeM7qIRKNFb8JfdJrGK3nZ4WAWF4XO91CM7ryTdqD83rQ5G/qLGPGuuDBdOpdxX679nPafE1/10vt7P4NYyK1k2fIaBhLWt5T1hc10S8szt0n7e8nvOeWpyX0RbhuczYwuMSSoNjPNv7wSRTMCWzVcKddiFhBOAddfnzzmCq08w2FOlRELmhq8M7Qz93t8nRA/msf31nx55rkOng9ckJnc60evOrCZ27uL22j8OFqNuUat73lIrBci/JCKgZJ1FnUnA03Lf482HFPqyNmw67RyGX+XxFlHgAh2Pk4GFwJYQ93Wtx9YfZ2QkneqiO+Pwgt1rquqmh6SOnjHHLdsDEsjY5FgacbEnfz1Qd9Kj4Rvvlj71+7i8A3OAz0/gO9OKW8R40sDK6lGQ8g4eiDu8S6oW+8ovtgxz2xEfhHs97cC7wIDdkIumRlJ0GfSvg7pKV2hIu0vpBLaXVRcryxZt/ZUEsmB7KWe1+bXhlyBlH1JIBXZ4SN/2+LHjak+hTMMGlcgvIsoXj8egq8TCZyXlMkHK9XGn3ZwnNnM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a626201-412f-43b9-fdc4-08dac8aa4766
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 14:44:49.4117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 75zuWqp+NcDoPclyKTS0dd4D6r/yFb3Hdt36vHA60Shf5/QiooTGn8Eq5gYmIi8w2AheOguuVhPKu7pFwP3VDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4426
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170111
X-Proofpoint-GUID: KiXFjDZVmzKAbpPqUTjE3DDlK2yjGvuR
X-Proofpoint-ORIG-GUID: KiXFjDZVmzKAbpPqUTjE3DDlK2yjGvuR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 16, 2022, at 10:44 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> This patch series adds:
>=20
>    . refactor courtesy_client_reaper to a generic low memory
>      shrinker.
>=20
>    . XDR encode and decode function for CB_RECALL_ANY op.
>=20
>    . the delegation reaper that sends the advisory CB_RECALL_ANY=20
>      to the clients to release unused delegations.
>      There is only one nfsd4_callback added for each nfs4_cleint.
>      Access to it must be serialized via the client flag
>      NFSD4_CLIENT_CB_RECALL_ANY.
>=20
>    . Add CB_RECALL_ANY tracepoints.
>=20
> v2:
>    . modify deleg_reaper to check and send CB_RECALL_ANY to client
>      only once per 5 secs.
> v3:
>    . modify nfsd4_cb_recall_any_release to use nn->client_lock to
>      protect cl_recall_any_busy and call put_client_renew_locked
>      to decrement cl_rpc_users.
>=20
> v4:
>    . move changes in nfs4state.c from patch (1/2) to patch(2/2).
>    . use xdr_stream_encode_u32 and xdr_stream_encode_uint32_array
>      to encode CB_RECALL_ANY arguments.
>    . add struct nfsd4_cb_recall_any with embedded nfs4_callback
>      and params for CB_RECALL_ANY op.
>    . replace cl_recall_any_busy boolean with client flag
>      NFSD4_CLIENT_CB_RECALL_ANY=20
>    . add tracepoints for CB_RECALL_ANY
>=20
> v5:
>    . refactor courtesy_client_reaper to a generic low memory
>      shrinker
>    . merge courtesy client shrinker and delegtion shrinker into
>      one.
>    . reposition nfsd_cb_recall_any and nfsd_cb_recall_any_done
>      in nfsd/trace.h
>    . use __get_sockaddr to display server IP address in
>      tracepoints.
>    . modify encode_cb_recallany4args to replace sizeof with
>      ARRAY_SIZE.

Hi-

I'm going to apply this version of the series with some minor
changes. I'll reply to the individual patches where we can
discuss those.


> ---
>=20
> Dai Ngo (4):
>     NFSD: refactoring courtesy_client_reaper to a generic low memory shri=
nker
>     NFSD: add support for sending CB_RECALL_ANY
>     NFSD: add delegation shrinker to react to low memory condition
>     NFSD: add CB_RECALL_ANY tracepoints
>=20
> fs/nfsd/nfs4callback.c |  62 +++++++++++++++++++++++
> fs/nfsd/nfs4state.c    | 116 +++++++++++++++++++++++++++++++++++++++-----
> fs/nfsd/state.h        |   9 ++++
> fs/nfsd/trace.h        |  49 +++++++++++++++++++
> fs/nfsd/xdr4.h         |   5 ++
> fs/nfsd/xdr4cb.h       |   6 +++
> 6 files changed, 234 insertions(+), 13 deletions(-)

--
Chuck Lever



