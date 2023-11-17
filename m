Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345FA7EF81A
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Nov 2023 20:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjKQT72 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Nov 2023 14:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjKQT71 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Nov 2023 14:59:27 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B17D5C
        for <linux-nfs@vger.kernel.org>; Fri, 17 Nov 2023 11:59:23 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHINwSu016703;
        Fri, 17 Nov 2023 19:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=43DxBEoNBuyzNlFL5xRZFR5qCLWtk+LYUcuHrBF0Rcs=;
 b=dNqxpqG5oWCM1dhmiZ7h/wP0q3834yGz3Rr1KYWIXR2QiASj7bLTnhw1aITU+J0Yx7Wh
 mmZ1Ey3GCzXr9e3kcPp+R0KvVDOKr1V1kDwhxAmVpOqOv3HS5pBldLF/iNN9oT+DmjcB
 rxyUmhrtSoPCnG5qQJlezxDEgtmv9HeQCkLORhhmL4uEo2ReYcBYIIbrvcGdoKBP4hsU
 gmzT6HvQ6T2QW5cimMD9cdiSggY/uz1+hBs59Wj7lB1qYfwWw8DnLgKmOgk/jpVSunPg
 Qvk7FxX4jigXm59MJ2XKn3s2WIve+lI0z9rlTUDK4qtmTe2xlAwqaK1F2gf5LKrxHdmm kw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2qde14w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Nov 2023 19:59:14 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHIVex7038444;
        Fri, 17 Nov 2023 19:59:13 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxj7t8vv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Nov 2023 19:59:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3lGmoHPxUlM0PT6b+Q5po1j4VD1wKa0cSziEjNDfNnHLX8H2T/kmIrLJcNx2DSc2EBeNeI7n+OneKTpQ3sVUlZx4ubDtD80Msx6ti9DQfhI7UJxkkUJJOkL8GM5yH2AgIrYkXWmAOpjbmNXghbhfjrmMuR+GE7d68WlWs1h+cdUl8lPLDz9Mcww0AUHKrxa1RZC/p/It/dyORGH9HMK0BKVWfHcDDWftcchYh1/KCsqvbn2Wu7gck7WiiBjSWfYZWLzV9Lk80eZICXWcEddAgxUfwyvhhoHxwDhchLqni7cXhtcT0ah+HBywhplGcV5yAaKaXcbrGXgHi22qZoCDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43DxBEoNBuyzNlFL5xRZFR5qCLWtk+LYUcuHrBF0Rcs=;
 b=VbSjcLz/ycXIiE1oTG86Pwa69HoSR3FiMa47X3SK408YZfXLwY7hhlQfcDIZloOhy459mkyZP94j/1zHo67LJ0/TcfZiKi5xysOl4JpCMvl9YPvP4OhHMkNqQD/0TlqYNVCrSVXfoh6UVlK+Ewn9aea622HkttoMkFuQOwWPzYA6dzFUpCr6cvpQbqeu4HDqnOe0TLEJlNsVEjt/AlcZygQ9mArYbPom3MaP0seSIwXFhmjHb0uZmTKRYyAvcYQnRUDvSC5Pti+xlBjkBIwx+u2nybSqnBjZLaX40R4fI/+jCS/Yk1EKEFza+LAmVbeR8owGrtBoLLY7rRcrTNn7Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43DxBEoNBuyzNlFL5xRZFR5qCLWtk+LYUcuHrBF0Rcs=;
 b=ofPq3WlGfH6HodZM6mfNcvy+07gpBAt1WIgcWRIaMz1i9Y1aTqot8lNRtuuRYFlSksOPr4cBqsbNokh5lChBDYF0yigUDAmBtCidF8kKqKuq+F6olUcd6xP5MrR2CS/RTRBmL95w9RB+VOIJhwBEmmh5sS2ocF7Gi4Gt71oWkjs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6288.namprd10.prod.outlook.com (2603:10b6:806:26c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Fri, 17 Nov
 2023 19:58:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7002.021; Fri, 17 Nov 2023
 19:58:44 +0000
Date:   Fri, 17 Nov 2023 14:58:41 -0500
From:   Chuck Lever <chuck.lever@oracle.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 6/9] nfsd: allow admin-revoked NFSv4.0 state to be freed.
Message-ID: <ZVfF8R2t3WH7FqVd@tissot.1015granger.net>
References: <20231117022121.23310-1-neilb@suse.de>
 <20231117022121.23310-7-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117022121.23310-7-neilb@suse.de>
X-ClientProxiedBy: CH0P223CA0020.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::10) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN7PR10MB6288:EE_
X-MS-Office365-Filtering-Correlation-Id: 632831dd-5914-4c61-fa29-08dbe7a79a74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5/Ui+WBLk1auKkxGQ+KIX5GmOwTpPmIiBIBoNZESqjIx8ai1jmSsmWgcYMSd8KlDYhMWsGYBeCVbw1st5SLGYgpkQWHUKissFAlCKYYnAFVFAWWLxhv6uWVPjpdnKEREQF2rd/fV5ndMq3daunYvqnb3SdgeT3Fs+vU+/vqPJQb/FviKtPEqgHkxyZvDq01PMcxMJWmSpMarWW7gOzCi1VAi9tswsYTQtfZQ+FFt+magKzbLzoP3kvrHkeBuMQ29SlJl6XnTWpVjyPnekzNgNnslMSc6KYFintRhfjhdplJqDjZhQezp6vc+gMUi9Xoung0h+U+Ghw2msc8itm8UISDbtW66nHepJoOIGIhvXHATQtHbg68IXjcFLCFCTUrI3Ntuhv5Ta2a5mYbWORPh3X7afpMz992ZsYY/jaQpLula7KKOYRM4BLtm2tDm3HntavckGqVaOmFXp+kLuRg3oyFOFNmWxEPocYbwW8octD39xaITTtwhxTTor8d5hTbyqjcgNofLSVzikT6eOYX0oX7nA4R9df5x0IjfCluzKSAdNZJEIoh9nWhQBIaycejp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(39860400002)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(6506007)(26005)(6512007)(6666004)(9686003)(83380400001)(4326008)(5660300002)(44832011)(8676002)(478600001)(8936002)(41300700001)(6486002)(316002)(2906002)(6916009)(66556008)(54906003)(66476007)(66946007)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4GcF75YMzfCnaHkdrLHfPLGS6aTV9ObydK/YF89G67IjRWpV6jGGpxAyZikw?=
 =?us-ascii?Q?lqFikGqdepZH4ActSP5tVI46hdi0SqSg50xkMZn3YW+uPyxn/1DxzS9ZuPkd?=
 =?us-ascii?Q?99/I32k7m+fy1oJpFKN5j3TzeaN8Gc6R0dC+yoJwDsi+YBbmAmrk6VZHzjUK?=
 =?us-ascii?Q?grSM/kqd1p9H+YbKLfZREuElSVK+4MAhg0rFXhGhtctTEFV9hYZqo6evm5m7?=
 =?us-ascii?Q?KsdawEu5usi/Bk6usZ8vr9NxruWv5WXtCyzGrQuWo3a8E+itdxJWomI2Hwuv?=
 =?us-ascii?Q?9VlYC95zSY6YALpZaggfgYyqJ2+no+KvxFGg3qhsst5rzawQ+Pi46aqQpsMI?=
 =?us-ascii?Q?VIubAGr54dKtukvE3cJEQIdorBou1fGYFcjEVtUc8aZjjW4WbLUvxjInOqsz?=
 =?us-ascii?Q?A5TDmsIFWWHPD2xszX/JGX7j8TD2BUnZy5QvONVSLtmQZ9XSR8R8PV29L+4E?=
 =?us-ascii?Q?9NWsjXCA+whoiOfEkBvHs5ffC1kunsDZPvge8KiTNtWlFOt+RGY+J0bhB9+s?=
 =?us-ascii?Q?Dx/7f/NLKLeI3PQQaNbaZShxu/JH6OBrznN3QFcY/44xO5AVp1xduLiYoJ+4?=
 =?us-ascii?Q?vzUmGZmoKAra3FfntDyA9Re2EGyGP7oiRBm5k9+AAwoAJge2UqM9XZ+Mqcyz?=
 =?us-ascii?Q?ifV+VHWaYvArZLcwPuHwy0QxGjx6UVFTXJ+dix5il+6B3FtFaYXqhIsuRqFr?=
 =?us-ascii?Q?OyvyBYbnnDAqoZ5YccaSnxH5WYTX+dnBIbzPf3d3shUwbPau5cOOUqFsyOL7?=
 =?us-ascii?Q?Zv9kcgG82GaqmBIO8gqS/EXjMgo3Nt0fWxKKFPh+D6ao8nedqDGA6klYkzPo?=
 =?us-ascii?Q?RrDrrjZ9ETNQr70QEjtfkM17jDvvmtnVgXWNXNmlPW/7sb71clFM3Q3UTXOC?=
 =?us-ascii?Q?Pk30MBxeu3gHeawtuaDrbrHUX2uLyu37z1VCfIyNVbNaBBHJaubbaYpuG6Dk?=
 =?us-ascii?Q?aWfFHhwPw2H/3Yxnd2fLTTcH77VGXqbPT3F2VJkVpJWxnAy63Q09t96Pgiaz?=
 =?us-ascii?Q?SQdAwMC4AAJLXSToDHvAnh/vZgvSgX1ysANIDhE/gvMgN08oYiW+aBVc3y4c?=
 =?us-ascii?Q?wpSthvY0kHFVwI99MmvQpXWgHTaoBYn6SlVu9LVGkzT2dxUH0cwfMTW5ELq6?=
 =?us-ascii?Q?WVP8wWBkrJswaeFJ8xSyd3vK1qEbwKkOtvwRWxjUvcaljjTMdjVpB7mRV/Tr?=
 =?us-ascii?Q?OjRC6JYgRlYCdF8XEqrLyICUik5uitbNs1uYfR+M7QL7Utbkm3O5BMNQDc9j?=
 =?us-ascii?Q?7kQDgMXopuX/Nj8pMmaTiK5rsjVD/H722Mm1NN6RNqM2aJbfyfMTcXVIXJJ+?=
 =?us-ascii?Q?RgSrB+2OBz3Av28ZdPrj3QUCHx5Xo3UGDDX9KLJhHtCY/jFkU3JUVgAUHTvp?=
 =?us-ascii?Q?QcZQgA3PyJU+dtDR/V9DbXX430LepBJQFtgRRp/Nv81EF4cwf0tr0ur58Ptn?=
 =?us-ascii?Q?qoM1dmYTGe7rfy5tPgtblFyKs/gk5kp/fd0mcwH1TPxP0vTUM2dEWgU9oGyP?=
 =?us-ascii?Q?JjMEvPsUyvdlTIkgoNROGcvjn/v8GtQ1vbED5MGrhgA3Tme71hlT6M3UMyZm?=
 =?us-ascii?Q?gqwSIquTtYKKleR6GxoSjGlVh0fduuh2fx4hc/UYGXi6LgR68oKysvWWpKgO?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BLWsgda7jdSQsJRHnlktN5NpKnom8JQ0xGVXAdl0NpINMyZJ4DViJz5kxFgHgkektJ0WRcDtNad4Pgv9flIShJEr56B/9wx89X/ovSMnNwDyVfm0e0WqPVqyqoiM6E0o4t30/a7VgS2/PeqoyZc/B47GKoGUAQ6TVIHn1d+RWFIqDtVXPGww/5H1qnAj2XviQIhAV+mMsfloTwTK/Ej6Xp+UvX9PT4dJBfJXKR+bF6fO+s8bsWzMuG24QQcPw+vPbTfLa/ug5/de2vOLojfIsEx7/iW3PI61aZNNd/GDpJRx18ai3aMBef8UjO8IQ9PWdLnanU7w5+0weqwHD942F/vsd2l+Jibxyc8t+4LEj7MjcZpuPclqfFsfL1Z+6MGKB2xMCKfVySku5/g1RgcKHsUEtbXvop7RtlSgldJdvhdhmymfsC175AilCvthgLNpNKLXpeaKKzw49NgdrPg2PBsGOoG3vd1p10kD68F6gxqCLxv0VZWIho+si6NdRqPR+wzeAAECmhX3nFve9Mmg5yMn0QpJFmU1r96O3WCDM+ncBMD5MqXl4cvsmAhptqY8k6xUXdeyZD+DNwzK9S1sRP+WM+tV2sXYuYgDe1qT4kW8TiRVW+JLL2C5hlhcENaLBrL4UwG/2AeaCc9CLGNga7PJSo4EUGMTCpNeVCPgowQP48KzJUGEz57EGtMU1Uzspoa7Pwa6VKvpSUc7ccT144FUPeyhht8n+pIDjVsfWe0mEgSfW0aq0XPtRenYH+PHistoOr5JBhHg+E4y8EO8QIIEWsfZzvlFqIUU/L8lq5zhQDez6bZkwCjSW3u8COc6+cUoVIOAMpkzaGwkDrZw0dKcIgLij4efyypdKHu1H0dwfaUIhmo6R7REE/RniiWI
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 632831dd-5914-4c61-fa29-08dbe7a79a74
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 19:58:44.1717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VqsyzQ3lGpyFfrVcPl0gu6aSXDiEo5/uMrb+YRAdiWyC8K4c8b18TJJywrfqIKF5wr72S3HQEHfFN+4W/lVhVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6288
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_19,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=952 mlxscore=0 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311170152
X-Proofpoint-ORIG-GUID: IlxdEXI45hDycs965JmtUu4RLIjvTb2T
X-Proofpoint-GUID: IlxdEXI45hDycs965JmtUu4RLIjvTb2T
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Nov 17, 2023 at 01:18:52PM +1100, NeilBrown wrote:
> For NFSv4.1 and later the client easily discovers if there is any
> admin-revoked state and will then find and explicitly free it.
> 
> For NFSv4.0 there is no such mechanism.  The client can only find that
> state is admin-revoked if it tries to use that state, and there is no
> way for it to explicitly free the state.  So the server must hold on to
> the stateid (at least) for an indefinite amount of time.  A
> RELEASE_LOCKOWNER request might justify forgetting some of these
> stateids, as would the whole clients lease lapsing, but these are not
> reliable.
> 
> This patch takes two approaches.
> 
> Whenever a client uses an revoked stateid, that stateid is then
> discarded and will not be recognised again.  This might confuse a client
> which expect to get NFS4ERR_ADMIN_REVOKED consistently once it get it at
> all, but should mostly work.  Hopefully one error will lead to other
> resources being closed (e.g.  process exits), which will result in more
> stateid being freed when a CLOSE attempt gets NFS4ERR_ADMIN_REVOKED.
> 
> Also, any admin-revoked stateids that have been that way for more than
> one lease time are periodically revoke.
> 
> No actual freeing of state happens in this patch.  That will come in
> future patches which handle the different sorts of revoked state.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/netns.h     |  4 ++
>  fs/nfsd/nfs4state.c | 97 ++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 100 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index ec49b200b797..02f8fa095b0f 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -197,6 +197,10 @@ struct nfsd_net {
>  	atomic_t		nfsd_courtesy_clients;
>  	struct shrinker		nfsd_client_shrinker;
>  	struct work_struct	nfsd_shrinker_work;
> +
> +	/* last time an admin-revoke happened for NFSv4.0 */
> +	time64_t		nfs40_last_revoke;
> +
>  };

This hunk doesn't apply to nfsd-next due to v6.7-rc changes to NFSD
to implement a dynamic shrinker. So I stopped my review here for
now.


>  /* Simple check to find out if a given net was properly initialized */
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 8debd148840f..8a1b8376ff08 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1724,6 +1724,14 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
>  				}
>  				nfs4_put_stid(stid);
>  				spin_lock(&nn->client_lock);
> +				if (clp->cl_minorversion == 0)
> +					/* Allow cleanup after a lease period.
> +					 * store_release ensures cleanup will
> +					 * see any newly revoked states if it
> +					 * sees the time updated.
> +					 */
> +					nn->nfs40_last_revoke =
> +						ktime_get_boottime_seconds();
>  				goto retry;
>  			}
>  		}
> @@ -4650,6 +4658,39 @@ nfsd4_find_existing_open(struct nfs4_file *fp, struct nfsd4_open *open)
>  	return ret;
>  }
>  
> +static void nfsd_drop_revoked_stid(struct nfs4_stid *s)
> +{
> +	struct nfs4_client *cl = s->sc_client;
> +
> +	switch (s->sc_type) {
> +	default:
> +		spin_unlock(&cl->cl_lock);
> +	}
> +}
> +
> +static void nfs40_drop_revoked_stid(struct nfs4_client *cl,
> +				    stateid_t *stid)
> +{
> +	/* NFSv4.0 has no way for the client to tell the server
> +	 * that it can forget an admin-revoked stateid.
> +	 * So we keep it around until the first time that the
> +	 * client uses it, and drop it the first time
> +	 * nfserr_admin_revoked is returned.
> +	 * For v4.1 and later we wait until explicitly told
> +	 * to free the stateid.
> +	 */
> +	if (cl->cl_minorversion == 0) {
> +		struct nfs4_stid *st;
> +
> +		spin_lock(&cl->cl_lock);
> +		st = find_stateid_locked(cl, stid);
> +		if (st)
> +			nfsd_drop_revoked_stid(st);
> +		else
> +			spin_unlock(&cl->cl_lock);
> +	}
> +}
> +
>  static __be32
>  nfsd4_verify_open_stid(struct nfs4_stid *s)
>  {
> @@ -4672,6 +4713,10 @@ nfsd4_lock_ol_stateid(struct nfs4_ol_stateid *stp)
>  
>  	mutex_lock_nested(&stp->st_mutex, LOCK_STATEID_MUTEX);
>  	ret = nfsd4_verify_open_stid(&stp->st_stid);
> +	if (ret == nfserr_admin_revoked)
> +		nfs40_drop_revoked_stid(stp->st_stid.sc_client,
> +					&stp->st_stid.sc_stateid);
> +
>  	if (ret != nfs_ok)
>  		mutex_unlock(&stp->st_mutex);
>  	return ret;
> @@ -5255,6 +5300,7 @@ nfs4_check_deleg(struct nfs4_client *cl, struct nfsd4_open *open,
>  	}
>  	if (deleg->dl_stid.sc_status & NFS4_STID_REVOKED) {
>  		nfs4_put_stid(&deleg->dl_stid);
> +		nfs40_drop_revoked_stid(cl, &open->op_delegate_stateid);
>  		status = nfserr_deleg_revoked;
>  		goto out;
>  	}
> @@ -6253,6 +6299,43 @@ nfs4_process_client_reaplist(struct list_head *reaplist)
>  	}
>  }
>  
> +static void nfs40_clean_admin_revoked(struct nfsd_net *nn,
> +				      struct laundry_time *lt)
> +{
> +	struct nfs4_client *clp;
> +
> +	spin_lock(&nn->client_lock);
> +	if (nn->nfs40_last_revoke == 0 ||
> +	    nn->nfs40_last_revoke > lt->cutoff) {
> +		spin_unlock(&nn->client_lock);
> +		return;
> +	}
> +	nn->nfs40_last_revoke = 0;
> +
> +retry:
> +	list_for_each_entry(clp, &nn->client_lru, cl_lru) {
> +		unsigned long id, tmp;
> +		struct nfs4_stid *stid;
> +
> +		if (atomic_read(&clp->cl_admin_revoked) == 0)
> +			continue;
> +
> +		spin_lock(&clp->cl_lock);
> +		idr_for_each_entry_ul(&clp->cl_stateids, stid, tmp, id)
> +			if (stid->sc_status & NFS4_STID_ADMIN_REVOKED) {
> +				refcount_inc(&stid->sc_count);
> +				spin_unlock(&nn->client_lock);
> +				/* this function drops ->cl_lock */
> +				nfsd_drop_revoked_stid(stid);
> +				nfs4_put_stid(stid);
> +				spin_lock(&nn->client_lock);
> +				goto retry;
> +			}
> +		spin_unlock(&clp->cl_lock);
> +	}
> +	spin_unlock(&nn->client_lock);
> +}
> +
>  static time64_t
>  nfs4_laundromat(struct nfsd_net *nn)
>  {
> @@ -6286,6 +6369,8 @@ nfs4_laundromat(struct nfsd_net *nn)
>  	nfs4_get_client_reaplist(nn, &reaplist, &lt);
>  	nfs4_process_client_reaplist(&reaplist);
>  
> +	nfs40_clean_admin_revoked(nn, &lt);
> +
>  	spin_lock(&state_lock);
>  	list_for_each_safe(pos, next, &nn->del_recall_lru) {
>  		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
> @@ -6504,6 +6589,9 @@ static __be32 nfsd4_stid_check_stateid_generation(stateid_t *in, struct nfs4_sti
>  	if (ret == nfs_ok)
>  		ret = check_stateid_generation(in, &s->sc_stateid, has_session);
>  	spin_unlock(&s->sc_lock);
> +	if (ret == nfserr_admin_revoked)
> +		nfs40_drop_revoked_stid(s->sc_client,
> +					&s->sc_stateid);
>  	return ret;
>  }
>  
> @@ -6548,6 +6636,8 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
>  	}
>  out_unlock:
>  	spin_unlock(&cl->cl_lock);
> +	if (status == nfserr_admin_revoked)
> +		nfs40_drop_revoked_stid(cl, stateid);
>  	return status;
>  }
>  
> @@ -6594,6 +6684,7 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
>  		return nfserr_deleg_revoked;
>  	}
>  	if (stid->sc_type & NFS4_STID_ADMIN_REVOKED) {
> +		nfs40_drop_revoked_stid(cstate->clp, stateid);
>  		nfs4_put_stid(stid);
>  		return nfserr_admin_revoked;
>  	}
> @@ -6886,6 +6977,11 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	s = find_stateid_locked(cl, stateid);
>  	if (!s || s->sc_status & NFS4_STID_CLOSED)
>  		goto out_unlock;
> +	if (s->sc_status & NFS4_STID_ADMIN_REVOKED) {
> +		nfsd_drop_revoked_stid(s);
> +		ret = nfs_ok;
> +		goto out;
> +	}
>  	spin_lock(&s->sc_lock);
>  	switch (s->sc_type) {
>  	case NFS4_DELEG_STID:
> @@ -6912,7 +7008,6 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  		spin_unlock(&cl->cl_lock);
>  		ret = nfsd4_free_lock_stateid(stateid, s);
>  		goto out;
> -	/* Default falls through and returns nfserr_bad_stateid */
>  	}
>  	spin_unlock(&s->sc_lock);
>  out_unlock:
> -- 
> 2.42.0
> 

-- 
Chuck Lever
