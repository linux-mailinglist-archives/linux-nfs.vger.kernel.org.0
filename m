Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B5E5303EA
	for <lists+linux-nfs@lfdr.de>; Sun, 22 May 2022 17:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346757AbiEVPwm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 22 May 2022 11:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239246AbiEVPwl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 22 May 2022 11:52:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31503A70A
        for <linux-nfs@vger.kernel.org>; Sun, 22 May 2022 08:52:40 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24MDJqcD018401;
        Sun, 22 May 2022 15:52:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=g8ZztifoiO3pMat8aIFbbWNXwbgC59FGBcj/nPs+fYs=;
 b=B3tZosYxZzPKLMtY8qqd04Km3ovN5ojukHfo5mNFaLX3FXzhUvIRIx6z1NxZc1vI9V9U
 DgxZGbFtvyIuw+56E6bidAw0m5wgMJr9biCbzIO4BCGLiWD1Nxl2XGst/RJKKTFWvH3G
 DwbO4iFvqY5A0kWuFMJmyR7X650kDoh5Kzkk2JyR9drT2/6WKSH9xUN1S+Or6gGpdWII
 cCOx6W4rWpshdOiX0Puj8r1db8Yo0VYl/DUyT52ZqOOzNNoQu9A91QOlVPBMu2Yg5abT
 Evmymi4avOqJQuHzaq6VH9fWFuePkWyT+8mIar8J/auuNxv1WUWjwM/f7jRoGpbiaC73 BA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6rmtsnvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 May 2022 15:52:36 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24MFnk6e009805;
        Sun, 22 May 2022 15:52:35 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g6ph74q5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 May 2022 15:52:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UF4ZVwQTqnQbVQ2tikIs9cFheNLzgY8uq617+VzzXQY4+IYzLhhr9tBMghQq/cjCPPJy45v4pZp1jnGiqOK+smqNd1Ai2b9Ej01mRfMEMTC32BeeBXZoVyJ3qgb8ntjmpnuaKclhp6rBhIfX4ANOPccOxYGCtBEL+nDp6q+DH4aHLtfFPqasYiIUkQ+LPYT5ImcM3mybe4MjFyu20RvuonISW7QOM23Cmn+XwMcCOv0c0Gorq+UE0KSt5GIucxWo5DZp+1vEsKsLw7h+apzp3gQXFKVzPx5dWFaWnvd25ipTZTjHsoPYuL7SyGYu9NYfwg5dMG/obvAxniwYckDt7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8ZztifoiO3pMat8aIFbbWNXwbgC59FGBcj/nPs+fYs=;
 b=cfKql1ELe9JThdbW3hB1quwQWGKL550Tpwd1+8Q4oiW9mDQX9ohtAd1FLeEwzqMP9N8rgvrpM+xN8PwcCjl7Y1Od4nM78F3PXw9s2KKvaObo6m+y/NECpuViyHth/fF2QnOLiqOubl5MAMB5LBnKC2j2SbfCQ4L3o0DTS787SSWf9dsbRsr8qmSOtqrSLj4euHo8dttxC9+aH57fCU3UGNRB0/8SwpuBgVkMyR55mn+m+3DCFc4WMjaJXc5ydAVodulTn30J4T4C7Z94E8LS74zZqLe3EIEZUJ9GeDjN2vCgLG9J8ALzGwcckZir3NLLhw5oAimNIoKJayBOR2LP1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8ZztifoiO3pMat8aIFbbWNXwbgC59FGBcj/nPs+fYs=;
 b=lDrHixEPb7nj+tOUB8meJUeNS4s0O6eYDfwRZXHDlTCFC4ayphtUJhaElPHyFdnrHhOQVPqs4MGFvVcta++nbdv4ZwEishh15+1sCttll9IZ2/RP2apFNOCW199CoqLLnZ1swm1f/AGEHikDuFgssdy5g7ANDxoV36naWfrjZ2A=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB3977.namprd10.prod.outlook.com (2603:10b6:5:1d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19; Sun, 22 May
 2022 15:52:32 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5273.022; Sun, 22 May 2022
 15:52:32 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Kinglong Mee <kinglongmee@gmail.com>
CC:     Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] xprtrdma: treat all calls not a bcall when bc_serv is
 NULL
Thread-Topic: [PATCH v2] xprtrdma: treat all calls not a bcall when bc_serv is
 NULL
Thread-Index: AQHYbdikgXKEdQSfW0SmS7BCQSM6W60rDDMA
Date:   Sun, 22 May 2022 15:52:32 +0000
Message-ID: <5123D71E-986C-41FB-A562-D38856AA436B@oracle.com>
References: <3d65c9a2-6c3e-7224-5701-c3e0060b6df6@gmail.com>
 <FE1A00F7-3CAF-4B62-9DD6-0EADF44D3059@oracle.com>
 <09f0b58c-37d7-4b8d-0285-01ec11601d01@gmail.com>
 <9F4E9614-9891-4787-86DC-944BEB45C960@oracle.com>
 <906dd00c-7999-4d36-0cf1-155ceb595ba9@gmail.com>
In-Reply-To: <906dd00c-7999-4d36-0cf1-155ceb595ba9@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ace00d5-bc63-4545-5b43-08da3c0b1560
x-ms-traffictypediagnostic: DM6PR10MB3977:EE_
x-microsoft-antispam-prvs: <DM6PR10MB3977589BCCAD6475B9E5A23E93D59@DM6PR10MB3977.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6+GR+YZKI7RPf2i+nEgzubTDMkMzfYZWdqkPf+N0bqZyjZIR34ULhx00PhPIDmutqUNV1ztWLRhljjBMi1Frh9GrTWRj+cNwNDaMUBqE25hKsyvRQNXlBrHFACBp6SwH57j8FjFkjXh/nVNPY0rGBn+DZq4bd9/Ul6ZeRzuRYpc1RnVx4bX7EyVXBBNOWIOMpySI6WRK7oqvSzeZwFK9AEKVe0xfspYL5FDVMdnKELtMHhhn0Q08UjXLwk6WJDE+zHYuSnig8eQF9ZzAVvyOLgRTZU5fxNikcqjzZkZsXHMl4zUA03J0g6/oYA+hG73lov2WW4HeETBWSfRjdvx7zZsZbq+jS4KZYQGhVsYxpsGhPpvqHAhy3avghMlEtg4Bd0BcFyB00/O475Q71FRCDwIpxaINQDdYY+Wrp5e1Mwgmugt2yl0rUWdNYHdOT9b+wavEnW2QrHs4Tn4bS/zS8mCzzyRoceTDac7F1EW7x5bVuJMjW02KasxVfq2Wq6q6rh1lTqRK1dsJF17TSTiF7pAcmMlP6kKmLWGI8oE4rXTWz5Z/1IKfA29kBPMEr2DEqKDXe9EhZmlXj7B1JpskaJUjw+vOkLXPRWHarH4lMzMAN4+5tvdgwWMcrgBhVxEqEHfPJna0p7P/DEAlT7RsSYKtlqCu86jLh9eXooZ89t2wpmuutkaclSW9mNulqDe+766GtLNsBBESZLoJB9VO1AEYnY5Ylf6coHB11/rpVOX5Ue4/y768BcQ9fjDxd8uArXHW4bRWQglCktYfubgYoQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(2616005)(122000001)(38070700005)(6486002)(186003)(508600001)(8936002)(2906002)(86362001)(83380400001)(36756003)(53546011)(26005)(6506007)(71200400001)(38100700002)(91956017)(76116006)(316002)(5660300002)(66946007)(33656002)(8676002)(54906003)(4326008)(6916009)(66476007)(66556008)(66446008)(64756008)(45980500001)(505234007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4MSLm6/5LoKibSU0t3cuy4SusNF2HRpF1TTrHm6Cy3OYbJgToV0NbNwZPBKY?=
 =?us-ascii?Q?kIZKLjCko8LKFKPRBpIxG03PZta8dbg3Iz315edGvY3oo5CKFPcKgkGZQO6F?=
 =?us-ascii?Q?ba1fF+akQ8Hz3AphddWOPZd6S7qZA0OSxz0VQXN8eXRiXREF4FUDg4xZRLBs?=
 =?us-ascii?Q?3MxELyE/9CFR7MvL/vVkM+RIP82qxoDLjsRU+sCyYhNb0FdPWOAXvwQHPJ9V?=
 =?us-ascii?Q?1lhHWQ43GNlPOgodGVj5BCT9MSyPC8EakTaEXfZZpDMuEkotAmFz9MDt+Ig4?=
 =?us-ascii?Q?MBnZaktouLOfDyarT38MkUAssYKq9XIo5H7z5ENEnufQqMbod4owIlGTW0d7?=
 =?us-ascii?Q?BNEuK5mdhTWYCD4E3gadxFCa4J2Dstu4Tuc1t3VaS0zE742Y4SfwEBoroZgL?=
 =?us-ascii?Q?yB/zWWQPwQUNXj4WpBFFi4TL81DiAjEtsQO5sCwWlvqTA1ll69FzIFbwqrXH?=
 =?us-ascii?Q?/ZmNbr6ffBlH9ixiuLKgS4jCw+Ky8Cq/ZUS4b7oKsrLfMNjO5V1Iw+78cq+n?=
 =?us-ascii?Q?mVXH9kVJ676JEdlYdOGS+A0louGj58bFKKiQVhA/rd8sjHgAyiMEBhtkgkNN?=
 =?us-ascii?Q?oct0Eq65hL+OY0RfUA80S5o/zGjv1JqtmdHiB3scdACc6JXdSCJ1COyCPdGQ?=
 =?us-ascii?Q?3czbBFj18jHD0kguLtKswHA/D+TJAPK3Lf7zMKOL546bYFrterTKpVLkbhnJ?=
 =?us-ascii?Q?o8lxyKPAVpTuNnkohJ2j5rMZCnsSDiyJ6BNHgkwogVk/s9ELcRxwGSIy7aBJ?=
 =?us-ascii?Q?6Rxb3yClm6ftWR/KJ204yLrh1vK6N4GUQ7g/QP8DAkUC/Eb2jJMbzu3Dkl8G?=
 =?us-ascii?Q?BR+vu/CMkgifrOTUcuo0Cf8yHxqn72ceRhYW6yJok8zbM1JHu3bjLyyYiOOv?=
 =?us-ascii?Q?znIkeOV6Tk2uMPhvztStAAN1CpUdqKbfglr6naUgu6bMoQI0YWHsg/CC0v44?=
 =?us-ascii?Q?SzONMUFcW82CmUUUK9cFeZLkEkTmUPV2DTgpzOqdID30oi0fyFVZTl4lHHqo?=
 =?us-ascii?Q?TvmcKBXtLmZorgJSKFw+mUhBIb2r8mcjTpf7xSkE9rMvdCGAuxAlhKUD0fn9?=
 =?us-ascii?Q?pmJguPfY3K5tGEGQkytnfVRUqaFTd5q9e7AFkD+W7VoPKfX+5eYHIsMmuFaS?=
 =?us-ascii?Q?Jwn14+tx1teCL+zjdZDBQhu/+tOS3ln/tNLXAM/yL1G+jPdG10anvdRgrAyE?=
 =?us-ascii?Q?cRmofJAkqLKkYXn6S0NRR0hEKTzhj9ZQIoz/Z3nUxRYUNBeG8pBla/wmCx29?=
 =?us-ascii?Q?QV4Q5IqMs3j9FEdE2Cvw4cWMRC3vmtza5fsUcC//h3wdSh7FgP71IgjsVfXQ?=
 =?us-ascii?Q?3/hH8LN0zefOivtJ1gFgvYZQcPWNdSYiR3xKSB2UCjkvDbIz8HDr8sl/Nk7r?=
 =?us-ascii?Q?+tUyolvJyHY/K2KCaVYBrWRjAnY6ujxNoqsjukLGJn7zkwwQYGWkRrBwpPom?=
 =?us-ascii?Q?BF0+ySG+oenIpo9JqlBvhHVbKhTI1042cH7tokF7KqwBeqm99a59PQmDJTgX?=
 =?us-ascii?Q?YKAUTZL/ixYVEwtWrG1e8fD6g8CMH5ulyfOvg5Cgeox8IrpQHGErOrUvhKFa?=
 =?us-ascii?Q?izzgtp+yLIZ+DmPS8evBXbHDhTz3hMkwFrKtg7H7P6fTXuDveKzvcbbDHzjS?=
 =?us-ascii?Q?H7oRT2nS2xjeKko5j3tiHLA6nh1Oq2o5k0r1RTQVIHnwOMOUi8zDKvRqiMXX?=
 =?us-ascii?Q?Pnj4qsZQhnVBZ1rBU75HyvbKhVP7ugMhiU3qAeBRxskycI47nDh2gpjB7nXC?=
 =?us-ascii?Q?SB0OqXkf6YrxK0HeEo0ovEI7S17fJZg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <25098CE8086E2E4DBEA5BDD40D4684D1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ace00d5-bc63-4545-5b43-08da3c0b1560
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2022 15:52:32.6977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pOyYZPRQ7YRqp4XAc4Jp3MPwNP67MnG74HLCKT5gILfs8eD/QpElTKjAdznEb8GelTebtoVHBBZWitEAJ0/p9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3977
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-22_06:2022-05-20,2022-05-22 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205220099
X-Proofpoint-GUID: aXTwkO_qtJdToLbX9_9bqLu8pk9CCOUG
X-Proofpoint-ORIG-GUID: aXTwkO_qtJdToLbX9_9bqLu8pk9CCOUG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 22, 2022, at 8:36 AM, Kinglong Mee <kinglongmee@gmail.com> wrote:
>=20
> When a rdma server returns a fault format reply, nfs v3 client may
> treats it as a bcall when bc service is not exist.
>=20
> The debug message at rpcrdma_bc_receive_call are,
>=20
> [56579.837169] RPC:       rpcrdma_bc_receive_call: callback XID 00000001,=
 length=3D20
> [56579.837174] RPC:       rpcrdma_bc_receive_call: 00 00 00 01 00 00 00 0=
0 00 00 00 00 00 00 00 00 00 00 00 04
>=20
> After that, rpcrdma_bc_receive_call will meets NULL pointer as,
>=20
> [  226.057890] BUG: unable to handle kernel NULL pointer dereference at 0=
0000000000000c8
> ...
> [  226.058704] RIP: 0010:_raw_spin_lock+0xc/0x20
> ...
> [  226.059732] Call Trace:
> [  226.059878]  rpcrdma_bc_receive_call+0x138/0x327 [rpcrdma]
> [  226.060011]  __ib_process_cq+0x89/0x170 [ib_core]
> [  226.060092]  ib_cq_poll_work+0x26/0x80 [ib_core]
> [  226.060257]  process_one_work+0x1a7/0x360
> [  226.060367]  ? create_worker+0x1a0/0x1a0
> [  226.060440]  worker_thread+0x30/0x390
> [  226.060500]  ? create_worker+0x1a0/0x1a0
> [  226.060574]  kthread+0x116/0x130
> [  226.060661]  ? kthread_flush_work_fn+0x10/0x10
> [  226.060724]  ret_from_fork+0x35/0x40
> ...
>=20
> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>

Patch is good, Reviewed-by: Chuck Lever <chuck.lever@oracle.com>

Commentary (no changes to v2 needed):

The description still suggests we are adapting the client to
work around a broken server. I don't feel this is the right
reason to accept this change. Instead: we really don't want
the client to be vulnerable to bad input for any reason.
After this fix is applied, bad RPC messages are eventually
dropped rather than processed, which is the desired behavior.

Anna, I recommend adding Cc: stable for this fix.

Kinglong, please ensure that client Receive resources are not
leaked in this case. If they are, send along an additional
patch; if not, let us know and we can close this issue. Thank
you!


> ---
> net/sunrpc/xprtrdma/rpc_rdma.c | 5 +++++
> 1 file changed, 5 insertions(+)
>=20
> diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdm=
a.c
> index 281ddb87ac8d..190a4de239c8 100644
> --- a/net/sunrpc/xprtrdma/rpc_rdma.c
> +++ b/net/sunrpc/xprtrdma/rpc_rdma.c
> @@ -1121,6 +1121,7 @@ static bool
> rpcrdma_is_bcall(struct rpcrdma_xprt *r_xprt, struct rpcrdma_rep *rep)
> #if defined(CONFIG_SUNRPC_BACKCHANNEL)
> {
> +	struct rpc_xprt *xprt =3D &r_xprt->rx_xprt;
> 	struct xdr_stream *xdr =3D &rep->rr_stream;
> 	__be32 *p;
>=20
> @@ -1144,6 +1145,10 @@ rpcrdma_is_bcall(struct rpcrdma_xprt *r_xprt, stru=
ct rpcrdma_rep *rep)
> 	if (*p !=3D cpu_to_be32(RPC_CALL))
> 		return false;
>=20
> +	/* No bc service. */
> +	if (xprt->bc_serv =3D=3D NULL)
> +		return false;
> +
> 	/* Now that we are sure this is a backchannel call,
> 	 * advance to the RPC header.
> 	 */
> --=20
> 2.27.0
>=20

--
Chuck Lever



