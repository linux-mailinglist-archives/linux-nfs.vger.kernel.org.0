Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F976E324F
	for <lists+linux-nfs@lfdr.de>; Sat, 15 Apr 2023 18:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjDOQNn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 15 Apr 2023 12:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjDOQNm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 15 Apr 2023 12:13:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5976C35AF
        for <linux-nfs@vger.kernel.org>; Sat, 15 Apr 2023 09:13:41 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33F4T9hN006352;
        Sat, 15 Apr 2023 16:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=eMPxkLcnf3ATQEmYaI7bwljHiC220SeIqahQJMw1LF8=;
 b=rR633MTcS+D3hxgifxRFlkspMR4Vt21pbCuKWhUddxc0w+i8v9dHWGiaIY+vN8BU4TYx
 CkZnAz0T4bptp0KSMPTMztKeb7zFBvy1w6RgQGSPAP0cy3tOLREvkinkBc7V4JPjRhEa
 uSkW7iL5rYmlLEB3JaQ/ZVcnRqzgVtSZ8rO89OQ7CAjZr4Vs5MUE3TSmBcYz2QYd3bb6
 mjO64HLN+OEmdRdvdIdwomv5kfuiHgbw8BWuFdceXQdM6ARhg2owSxnxEmDTp9YovqFb
 25VzfpSRxm1AthH3A5qpCgYi/F06Jg4hopBh2NjUqJ8wg4p8K30ekaBw+KuYaMyTKJHS WA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pyjq40n0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Apr 2023 16:13:27 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33FCAYpL023037;
        Sat, 15 Apr 2023 16:13:26 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc2de42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Apr 2023 16:13:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBujOFY4IhCmSuhsd7wNpXOONcexi+d+14aP7sPZJNB4Jz3cALAYV0FGuYnEGXwAgAqim2vbhYYiYO0p7cx1zkDn1kPNgVFLz0kuihhnE2i+r76q69VDON8CLKCMJvXUVk+TJ+nc1C4f4No3zIRCxaNdDyQ8NuYe3fCeJevS7KtLY6UHUhwMyQzA6XUvjzNf0g+AETOMlhLFQ9FAJtaMakzpflEfY32DL1A10smsOQU7ZcNDyK8bbt/JJtrrYmlI2VmTyUi73K7p822N4CW0RhfNnaOyZpeFmP+AwSTbFq5i5pt+zlKBnO6w+OfDnheRm6oR4MrMHDFIjtdPgEOyIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMPxkLcnf3ATQEmYaI7bwljHiC220SeIqahQJMw1LF8=;
 b=P3fQtluDNudUhHqVVWRRdNd4iVCJ1taqVd+zb9nZPn/5eKU7sjuceKGgmVLwlf/sPkk9Ql5wrZ7pjGuqKlyGmJCte6X4iuNajWc42i6Zz9Xu6v9v0ziZgAf+j+CKSlqdnQ7hlWEvzE96sS4mMfI2wFOJA5XKJeU4NTPZ7MNgIo2EYeDq63vxKm4G+XTxshN1cKsBKzJRFzP2CTVK2suOleftzFbFRZx2yoYEuJ5IxavE0BhSkra1Np+JGzPuGVVhzPLRBv4TM3v/TQs/UBoDS1Hk7Ao16rHRm0jofntajHLfgXROfvklC4s+CyolsQ/df+LkSQFgD0YU0fJ3djtH/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMPxkLcnf3ATQEmYaI7bwljHiC220SeIqahQJMw1LF8=;
 b=uQiAO9AVuFUI6TYa/bmWtI/PzlEuNawMkt2vJgPRpOvodY6AshamjG8476OCZM7lJYll+T0d0Yto0BnZ1X7DKXgevm4fInSVdSTG4utYA8VcPrHOAVNK3ySzwWUs/5k35EnrjEah1CgFh9rJJfYKYotvyEChbGwVsuUwWNy1lHs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6225.namprd10.prod.outlook.com (2603:10b6:510:1f2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Sat, 15 Apr
 2023 16:13:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%7]) with mapi id 15.20.6298.030; Sat, 15 Apr 2023
 16:13:22 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
CC:     Jeff Layton <jlayton@kernel.org>,
        Frank van der Linden <fllinden@amazon.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: don't use GFP_KERNEL from
 nfsd_getxattr()/nfsd_listxattr()
Thread-Topic: [PATCH] nfsd: don't use GFP_KERNEL from
 nfsd_getxattr()/nfsd_listxattr()
Thread-Index: AQHZb4qhR4jn7R6+a0evVV4Y3qmRcq8si0OA
Date:   Sat, 15 Apr 2023 16:13:22 +0000
Message-ID: <4BC7955B-40E4-4A43-B2D1-2E9302E84337@oracle.com>
References: <72bf692e-bb6b-c1f2-d1ba-3205ab649b43@I-love.SAKURA.ne.jp>
In-Reply-To: <72bf692e-bb6b-c1f2-d1ba-3205ab649b43@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB6225:EE_
x-ms-office365-filtering-correlation-id: a897dd16-e335-4758-e010-08db3dcc5590
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s//KcZgOUESBUrX7eg8QwT3PnRiQ+jLlTw/NLzuLI4sCGStEFRSdgIn0djU/x9jZ2OlQJ6xXh9PRxonygMncUXVsFdA6yE4fUb09Eogk9ZNBXkFAHE/lOf/npWkC0SIWWVDUHbNHqUfanr1zsI+nWC0fRBTaI6QtGflz/gmUCXgCxAoNoeL8OI+dLD2sHppvAf1v+v0SXiIJx3CdItSsqzT3HhHUe066tR6P0GAXv+KcDSF6SHjsawPkdER3xwdq0kMywmJ/YS7QlGufp/+EFJ1o+6uq70l+L4NaIlu9AGd6Lg0eRQkaimT8GOA0GTrzlMuM0Ou5+MpAH1QJek7La7aOIAxt0d/KJWcdfEIId1a70cQYWhnp3BfsKv2ielox6JU0ZZOnhYId2EA1KrJtZCMlVwaByvEyVG3CEv/FGTkUJAJBWf6rQ4jotY0HAbrolN5govnixqrYUHvtKbrYpdknYpfAi2kKCiAUpcIxqUE2TiNEwVZwVQfxPt44QrKu6TMlww+sccyXyVDpnL0cHLIkg+Nscp2c3v38/lsqRwV+AyIcpfFutOcrYjLjvFWtb4g2C6wKUujR7pl2WUPnKAzfeJf+VL4dI6uhmb1No4ZlGF9WOuF32HLZPoMgP+7KgCYdNYlwYf/qHsG7DnxzZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199021)(71200400001)(33656002)(5660300002)(122000001)(36756003)(2906002)(38100700002)(316002)(8676002)(38070700005)(86362001)(8936002)(66446008)(66946007)(66556008)(64756008)(66476007)(6916009)(41300700001)(91956017)(83380400001)(2616005)(54906003)(6506007)(6512007)(26005)(478600001)(76116006)(53546011)(186003)(6486002)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ueWu7yuMRqcsEQIUCtcRkF5HokLc+84pFMyxyogNlawySMVjc54DZBYdLx6B?=
 =?us-ascii?Q?2YI8WlY/Fb/jRiJuvPloPW6FlVD+yuR0PragPb/wTlAPXGHsyk8NiBHrbA1K?=
 =?us-ascii?Q?A6xdBiJo5TdGD2UEgZQouRLzH0llGX6a/5/MX4q/SUP2baEcQDuLfiJQbQ5Z?=
 =?us-ascii?Q?hx0x1vI2zhcV3RX4XdRwaN8KJ8E7SoXGT7dRs+iGw73LZA7ugz1+lIsiquzA?=
 =?us-ascii?Q?5ZAC3rKHWeCDHjC66KH5LOqvhP/LrZ1e/ERTDlJkh01ZSyayTRv6y+6MRTR4?=
 =?us-ascii?Q?Kd+x15TaSm56QVaA+dJqPJLQmTknfuDUHfCoDHcD6R1NTRLUx7qMMwvWrEXK?=
 =?us-ascii?Q?jIyS9cHR27ndrOA9ONsU/ycBaQ2SmjfbMlttNj/UhhHvE3eH5PmwdH93HXr7?=
 =?us-ascii?Q?iFU08jDl0P9aM/CAqzM1xM3JTwkNWDUnHwYDrEBWQPWvB/ilur/BAeq4CNto?=
 =?us-ascii?Q?KFY59mrqu0MiA9zYQdrxK8zD6gdy1oK2lik+6z2M7CvZ5tlOyB2Beju+0+Kz?=
 =?us-ascii?Q?URddrVC4w1yUXeQmThqQARBVJ4E+Z2m8GdK1dcVMYlAVE4lmVlzbM2IpA2Yk?=
 =?us-ascii?Q?aBEwnG20A9K/u/a8kSfJkizWrd4FFnzKAZD6M/rg8OuhB4ijhFEpfo8+pnWR?=
 =?us-ascii?Q?0OEMnB9qKDvxeqhnvCsxRaqwjM+R+pXNHE9ERhEn/PiG89GXecAjnR5iiChE?=
 =?us-ascii?Q?XlNvTHeB105WcQEaaY5GvSooZGsOpI7XxJWJMq7jWsdPPHB7gzLASPOdFsGS?=
 =?us-ascii?Q?kTfEQ4qqJGpxz7M1kfJcBMXKuUMYAk08SVInvdbROzwNROpBHkN2nd448DVx?=
 =?us-ascii?Q?YAVFAXBOMVz9dy2Yv5k6MnBJeAhcOC2hGcX+hmZQ0O1zfmYzWfGS+l1XpafO?=
 =?us-ascii?Q?2tODpf/+T9S3J/a9qt5h4eyyzUAMh7BwUFCXG8V3V7IXa56DdESoBUQK6SDZ?=
 =?us-ascii?Q?O1+aNnskQay1LfC1RSm62IcxB6bfDYYcqXFpGMq9DLNec7uo6RPYFK+pnGxc?=
 =?us-ascii?Q?0yAE6Z/uw3GPknkyZ8Ek4v4dKz1lV4dygub4RnPlh2baAtyuoJdpsUz5LGjq?=
 =?us-ascii?Q?3U1k73D+UxDs4pckTBTnOyt88dqxWHUw5B2LTQKcuaAGsV4XsR+QZKfPpQ1M?=
 =?us-ascii?Q?u3D7PETfS7gqAGn8kPmZOoT4q4U8bVmFTQZX3reWIZq2fjeVVvSE+jcD7NLz?=
 =?us-ascii?Q?XLz14YAz2IAEaFOSxaHCx8iSQYyL8WfN4ulZtpShpI33GL8OwODWMlIHY04k?=
 =?us-ascii?Q?QIsnlYWjMovCaCIn7QLsVxg959779CJZq2uYFMfMgVKYB2hATmbgsmG7jiHh?=
 =?us-ascii?Q?jpn8uNZQyBKVNEZ4JZIa20kViE7Cvjn4le+WSEpSvazROQH9bnteWgUjGbwc?=
 =?us-ascii?Q?LzeSWZ8Tu4IZ6ZRvZ+db/v66HONtUWMv7lQydAf/0TrbHC0JeO5/l0vicMES?=
 =?us-ascii?Q?tsxDLxArRrE00TzMInyVtWRG35FjvQlBvhCfFNx9cPikNaDcRPaoEVjPv46c?=
 =?us-ascii?Q?pmz5e3164NRia1ztiL3mKerS6JTGew/EqvzobYZbt8tucEvekw0EFDRCG7t4?=
 =?us-ascii?Q?vlvKbhgw/hVorSbxnVYqeLX1wfAvMNBykyEsqK3RBZtJ3UCSF5ykkLAJAEHy?=
 =?us-ascii?Q?ig=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8B758FDE992BA4438A6BF03E70D2B389@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QD3hfYEENHhNR/LBvvYjFY3v+KxrpNqtAnMMKGeRsCjrCaMgoPtPZ5hW++kcPeKrGtwEafkXY8nGqKavqiDR6RWmRnGx6GJzTevCwxzooj1TcesC8kj7kPoaovwzXzbIzeI7KVuruDVhxTnMFSBdSz+itl+qRPHnt4rCbjPXGZqujS8opaxF1FXc9Mz6uxruib6n1xk2P1t7Y9DS2H75la7siy1Hdt4kFV+oes1E5y6VgL+ZYquAmVCamF4EykyDklIvP+dubAJmsyxWPxYt51mt/uqdsXMO05tWi/LoMcEBaL8uaY2meBep+yBf7BDj3QId6FgqlKP5vq7mPNMGSQsgkYDzyTIU/9fCg+XaCsj+U4/RtLUZOyKsZ7dcJaUwCC8OK9sGM/I1p8S2Fa5dEsUCEbsk4lZlnLHiXyj8Gl3KD3mOrJ+6Ay+AZJeT4jmpkGN8WGwFnmdyG6ELxD6ugq73GS6sXvzy8IABjCkEoHfK+3ZlRAlxxTkbm6zzBFsGwlAHe1JMKDCA+RziwjGGdYusxy5w401SKeysZdFMxTSIrsPhQ1HROPgg7hF0O1JE4NCw9mKUivGJtJrz4vEkmT/L1cf14NW7K0bzmUwjuzy1UTWJpckKzVIVr2e9LxcqFZcxXn2zMKHoQpl5baEYzN+XK0EgEomndjHdcaEKD33yKkSTfDkxw9W+0O49H6oRxWy6cfMaSl+d2I0RqWs5YtlpUCJjGOYrlh+4fmNimL80kOWkUWPR+4Li4zvGJ+wxlQWzNlcW2cSIeBBhCMSk7pmL39O9+vPUDVZEWUO6Y7hcCAOuYGpNVNRIVUP1Zj9DJE7OV9yN+jB7uFZvec5YGae6Rx1Dftq6QOxKr+Hi43GsGKdi12u+SZAPj3l1obTK
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a897dd16-e335-4758-e010-08db3dcc5590
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2023 16:13:22.0904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iSuqxrRCEU4LRPtXVCGRXhu6Pc2vRh4f0/G/x133rZv1Epuazqy8gdaM6Y8oa56XepCvdxVwfxQkFnZtkbHW4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6225
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-15_07,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304150150
X-Proofpoint-GUID: alMYYhXnsauN7uVtO89RgEl9Z113LfMU
X-Proofpoint-ORIG-GUID: alMYYhXnsauN7uVtO89RgEl9Z113LfMU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 15, 2023, at 7:07 AM, Tetsuo Handa <penguin-kernel@I-love.SAKURA.n=
e.jp> wrote:
>=20
> Since GFP_KERNEL is GFP_NOFS | __GFP_FS, usage like GFP_KERNEL | GFP_NOFS
> does not make sense. Drop __GFP_FS flag in order to avoid deadlock.

The server side threads run in process context. GFP_KERNEL
is safe to use here -- as Jeff said, this code is not in
the server's reclaim path. Plenty of other call sites in
the NFS server code use GFP_KERNEL.

But I agree that the flag combination doesn't make sense.
Maybe drop GFP_NOFS instead and call it only a clean-up?


> Fixes: 32119446bb65 ("nfsd: define xattr functions to call into their vfs=
 counterparts")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> fs/nfsd/vfs.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 5783209f17fc..109b31246666 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -2164,7 +2164,7 @@ nfsd_getxattr(struct svc_rqst *rqstp, struct svc_fh=
 *fhp, char *name,
> goto out;
> }
>=20
> - buf =3D kvmalloc(len, GFP_KERNEL | GFP_NOFS);
> + buf =3D kvmalloc(len, GFP_NOFS);
> if (buf =3D=3D NULL) {
> err =3D nfserr_jukebox;
> goto out;
> @@ -2230,7 +2230,7 @@ nfsd_listxattr(struct svc_rqst *rqstp, struct svc_f=
h *fhp, char **bufp,
> /*
> * We're holding i_rwsem - use GFP_NOFS.
> */
> - buf =3D kvmalloc(len, GFP_KERNEL | GFP_NOFS);
> + buf =3D kvmalloc(len, GFP_NOFS);
> if (buf =3D=3D NULL) {
> err =3D nfserr_jukebox;
> goto out;


--
Chuck Lever


