Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E0D7D71F3
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Oct 2023 19:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjJYRAn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Oct 2023 13:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjJYRAm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Oct 2023 13:00:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CAD12F;
        Wed, 25 Oct 2023 10:00:40 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PEwSTL019310;
        Wed, 25 Oct 2023 17:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Si2PmPqygp8U6t76G313TGi8bhj72J+pkyaxvVPV4lE=;
 b=lrPQXVvhyFnjE6+KqBQTohpHHsp6VlSvJAEhDX+TwvNLOuhLrUrmeXNKv9LZ0gznHLTz
 snDe+8z309j2ONTfD6KPFN/YbPSnktn9VnZmgHca5/AvkthrmFpw6hpiFJJA/IpZBfvu
 ZPjZYSNq/Wf2mQM9K2H4wZRXW2xcZdauIa/O0uAYY+rsnDbWVOpW5S5ipwSB7a0qm0Oz
 mzVgeW4UQoYhOO5uKcNOTfwzjgMytzCnsUa9nhDF4YBWbyPAudRX8T15/3pR9Kuag4i8
 HQBjpdQi8UQR8HXWPhJ/lXtxKLmI9o5JFbX+qHJwsPz5CcJ31oGDFPfMnDhmwc+zguk5 1g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv68tg82q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 17:00:16 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39PGuRcP015122;
        Wed, 25 Oct 2023 17:00:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tv536xbnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 17:00:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPnTRdDFNuDf7cg8uZubLz/Qcr+cIXNqq4ggOnuWsC+3tVJOt/957eUNKmP0hS5ifv8JEKVGx7Na8EY5tqovublHvGf7+8ggeL6JEHf7sRECS/HwkeainDr/2aLA8U8PPy/90H+Lcg1hhEyteDehWWRHUSbnapDfBSgY3eulhtp6CnkXTqyzX3c80/b+lSTEVEMneHBL0MuEFUNIHmABLjY+TZseRhhiLAB+lQ4ObWhjBlNq8pMOznQI/Xhi7oYnPUhCjSkqufNw6V+WetxScCHu+H3rEi1E9GOON6QubmvRHMHNnsNKq9zqN2bLc4CLV30JLXkO3BD02hBqhT35tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Si2PmPqygp8U6t76G313TGi8bhj72J+pkyaxvVPV4lE=;
 b=iUcbtr+aK27SE3WVVKKQd5ljM5K1jNpRM4t7INCDvM2PWoOzhkgSL7gjAj3CHAXzCJ/q+qh8VFpzQgnxSIXoid9B4sfWbw7bDpnCHQEm27Gpkjv0H44tiJZ1DKYnNqoeTrHQEomn9Ze4THoDxQbZB8/SOD6S12DFYDhPWRKT+Ne3tIBJDzOoBrYrrvK4VmtCXa5RyFQvSGeiT5nEaaYwDUdONkXLx9vAI19+a1ps09vssHREa64GNx/M4DqDLcSeCn9oF72L7M/Uda26nD+s/BAdmXy224q75Mh8As4maHn+tpXaGTKcM+GTCODDO1WebTN4THwvqMi85kJ8aQGDug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Si2PmPqygp8U6t76G313TGi8bhj72J+pkyaxvVPV4lE=;
 b=VU5HcH92ZI64MiNgt8QqzCn6VMcttfKNZ6uOxHzC4Z4ePtzWpeEGHCNQ10yZ3qQ3sOUo5qzMOAgj5tUan3cKto7RgxlshhhL402ba8MwkwMTf4dVlhdR+KIsraZOR2F1UZI75lFA++GAu2zDrBIyBpo8AOhAAOrrd5OAC20uDKA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6808.namprd10.prod.outlook.com (2603:10b6:208:428::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 17:00:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::7c24:2ee:f49:267]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::7c24:2ee:f49:267%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 17:00:12 +0000
Date:   Wed, 25 Oct 2023 13:00:10 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Ingo Molnar <mingo@redhat.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: nfsd_copy_write_verifier: wrong usage of read_seqbegin_or_lock()
Message-ID: <ZTlJmuDpGE+U3pEF@tissot.1015granger.net>
References: <20231025163006.GA8279@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025163006.GA8279@redhat.com>
X-ClientProxiedBy: CH0PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:610:b0::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB6808:EE_
X-MS-Office365-Filtering-Correlation-Id: a189cb1f-70ba-4fcc-f32b-08dbd57bda8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GX/7Cz3G1Zek0TvLOuWvQKg5+DfKjK9+/nlNfbT6IO0A+TI6ex7YPMKU0guptO6me+k2ElU2ZkrTVqdvd4uqkyOl6fzWL0An/nDgtTmiyhe92c3UhZJc4B+bCfJ0w0cuvNIO0VPvJy2YzmeGHRak3Pd74Z3lGXWauwYJHcnaZqabHPEGzKi8DhBcvd8WoR08F88oiAxICZQtN3q13JpJrMZMD/fgeqvIGa8oKQ8j0+ldfsJ52bfSY/OaXDufvcBcB4n4dXUVlG6PAHqRgGh6RlntGTHAXsmKuxlZFpkMizMhw0IwpnEIwwWZUuTixJjIuF8YZIw007kyCU78EDt6D/cU0Mj3147zmes6hKlJf+gboBU92QND/Y3Ye2RGEdLvDNuqrv6cuKLtmsKdQkM8ycFrSSpf/UMnnu/tONAxTwvyXsWuBrRQhX/SKyXaGU3zTG6NTCNLXrToW+jwgxo5x72EARfzqJf1PnMG9W5zwDAwHg21EIlEYKHx3uwVaI4rTg6W+gHj/WOdnzADKRmC1M/mXj1G4ToM0G7U51LRwmhkTl5Rcl4s5NzKM9At1yLJLyuI2WVcXsoAFKt0wlMx2joIJ153Ss7ejOHnc1tggL0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(39860400002)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(4326008)(2906002)(8676002)(44832011)(8936002)(83380400001)(6486002)(9686003)(5660300002)(41300700001)(6512007)(6506007)(86362001)(6916009)(316002)(26005)(478600001)(54906003)(38100700002)(66946007)(66556008)(66476007)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WIs3oNMXPnRJrZ58i1VB0bRt2UHhyWv4vOv8QJO2q1dXLDImXJ9shz7DMezP?=
 =?us-ascii?Q?PNbOpL1lkhcQX16Z88NWMPyVgoTmk9ezTvUdsMyGskXe3yHdfiZcakRX4id5?=
 =?us-ascii?Q?8JeetVUlxNtNAPQC2HfUGbr4EQMmWtMuIFXZ3PDdwqmjJr8uQHCtG/wNTxDs?=
 =?us-ascii?Q?MDA2MBDOpqrXiJZbrfllPWvaGO57Ih4unBLM7IqCOjtkxjH1+Ao1cvKLD4Au?=
 =?us-ascii?Q?x41lZ+hx0Dr8mFCeJ2wKeNG4RYf4ScaKMnNYwV+jhHnAeLRTJ19X0V4Sqzdo?=
 =?us-ascii?Q?VqnDs2NztLLqzIENfYcJGbhbC9jsIcsCMViet1UZIqddP5+B9CUGNNTR0wyM?=
 =?us-ascii?Q?AtANh89qnSxZCZRSc+suY5tyMfJgVZDiqfNGKZ9eInaizaYFjK/NEIC2Gvdx?=
 =?us-ascii?Q?v08XtcM5c6ZB/QypVw9mBNIGi8PEQhK6rVJ5I3s5AtLz/DQk9lXBP5SINmYN?=
 =?us-ascii?Q?iI5y8AM8Z+TRcYD9B9Ip080pf94WysGzWIPfvw76E6ckigEx0hhJojGPAKrl?=
 =?us-ascii?Q?1fEB12FyLpdDR3rN6DsO8uqqh21tfJgdFco3PsvpoiA9ovktOcvYtN36wZ3q?=
 =?us-ascii?Q?/4ixzmEFBgArmiAaIQpyiiVwODYqSkTa4ZST46i9q+ZKYs1UH7y5xpk6PCY3?=
 =?us-ascii?Q?YhPTPUSK5oRsFHvQ/9yrWc2j2T/yDnGJxfGmJBLHyYy/0n9qvR5zpdWYrpsq?=
 =?us-ascii?Q?5WQUe0Id4BG9jL4a5k5PmWf9LNM0CZTiTjBJdz3pKhT+QIXn1ltMdS3CZOAR?=
 =?us-ascii?Q?8tj2VueQ7IawaOIpTUpfL3D7tokj6VOoQ7/Npf/abuyzwMfcSMYD8Xys1G3y?=
 =?us-ascii?Q?ZgR53p1sZDf6rhxxmM2XxyalaQllQVimINd3N/14+ymE8rweh0FiRljcfD9K?=
 =?us-ascii?Q?mnpiipo2uVhixsCPTECYEv0gPGH79D9ffbLntLVpJVaXakDz71COugCfLZB/?=
 =?us-ascii?Q?Emj42DFrhuj8qX/Tc7+ezUHC5Y3ZfBvbB9Uiaae2lQIx2sDn+QGdBjrwD2jy?=
 =?us-ascii?Q?vTnTN6ZIQNhYoBqy7B/4iYNEJPypKyVuT4tm+/yA0z5iqlmqM5UApYSv4LbD?=
 =?us-ascii?Q?bl3M7qPOaqkfAfaeNEJZkIdNv/42MVXFoom8S+FnPCWNkwO3+DedXMqoYi7C?=
 =?us-ascii?Q?dRg/qQgjIDOXAMOPa0orDqJW1nwIVXa5m2ysbA8b6GEPA327aom0zHzhi2UE?=
 =?us-ascii?Q?JQ5knQKmwmzZOJisygSjYWDrRgjD/ukjeVWPO2u9rKAs+8WXippK+NUvGJC0?=
 =?us-ascii?Q?IjMQjtOkibn00TZbGMjz6s60pujI7Wa+1zLDtj3aPp31lsZnVXDq+Ile3112?=
 =?us-ascii?Q?Zm4xSacECcbZvSxbE2oDgeJFPn51md3fxZXIPjvRlHMcwvN6CcnqNEs4kP7F?=
 =?us-ascii?Q?LgH+bzJ9p2Xzu1TYx68rhbyAlstPXnEWg+w4cxZb+4yhUVV9PCS3kOwLt5Si?=
 =?us-ascii?Q?tcM46OezY+1cG1X85CHA5ts/KNwpscu4qSYVTglVhyj8yY3lhTyGOgTXjANs?=
 =?us-ascii?Q?yCm53KzgBeAXsLqbsXZRakscT+V9ZhxRtTVDkaX1JDOc9QxVnA330XsYMT5u?=
 =?us-ascii?Q?fmUpSF1bykk1oiGREUaUpYBy0mJHwpbhPEWvmMl4mlKmfeNoSPukZgsWGs7D?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wAHv5Bv6iLvRrijvrn/Nt07IHN4BsL/yxcLdN0OthlSr8fIrqNVAHFDehjm0u3Q75xCDvpWHW5niyNcZDRONnMF6jiiGA098CXEFHsZkFmmtICykNHa3isnnvBIW9a4uxfJwshm547mVt7SpjEy1e2HB9U7cadu5YSQR0AcI2EddtNahMGVEcoSyTpWDcNUS0p/VgXQ5vqdbe/5Ce8YWayFDQjqXKqYIPM2SPpd7OBwtKZyQumAI5V2vzV6zBVH2+nRs7+DNSCX6kRuDuAiZ9cKEyvVoYQvMJMBsUc2K9WJXA7n70LzUiyBmcq3jA7FK+O2z6NZdGBivVPabMWLXv0Xd4RXLeChpiT0qVjnnDoaJ0fHXCZ78JRVT040QvKYz2YvDTR2jYVh8mriVZVHwoPkWeS+K0bcfecVd02qq0iYMC5+X7OaJxoWW4oR190TMzVoG1iZ0JB9tbmVQWacKQz9OxrCSFpPXZXLLj25ugfxtLhAYZNVPan+Pc8qYzKqlj82o8lW2u9sm0UX2C0Zj3EPaERQLIou5T4nAf+3LMnLWcRJdfV7FR2F7NZTF/YMvZ6GqLZV8YQE5nJCnxnOa/m0JpeiTo7TM56ujDr/d8lxMegOeLmRrJBwfSU5WfZs6x8Pwo4NMtNMT+deLyjN2LvOEVFugus+zoEWl8E89jjs0ccRHfGquefSbGW61JUcDGMnfqPHeyU9aOzM2TZp6zql2k7XDYpvmztCzEh34hTv/ONs07V2MkgAaL4hDsYJ5wPZ8tUYB+2LFHMeSMjD+IOM+22lBgOWh5hMsR5/I5EtFK2q/oehqooie5jYG7MGeVBZFyhiLQrynyysA6Nnk/ZWsOfG1keRuV/8FGeBT+VAHIN8OZt7nXmJj/74u3DSKuZKSmXmEMUXltn0bFJZ5rQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a189cb1f-70ba-4fcc-f32b-08dbd57bda8d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 17:00:12.8516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NfakN45MhAlulEIkKBYe6hu6r9E8AlwcLJRpDbwEt/dP4+9KbSrQudh9HCL7A0MIuctoPefacS9c68FfD0zzHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6808
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_06,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250148
X-Proofpoint-ORIG-GUID: bsUWBbduS0Fx7mRyy-v8ZEObAp9kb-wm
X-Proofpoint-GUID: bsUWBbduS0Fx7mRyy-v8ZEObAp9kb-wm
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 25, 2023 at 06:30:06PM +0200, Oleg Nesterov wrote:
> Hello,
> 
> The usage of writeverf_lock is wrong and misleading no matter what and
> I can not understand the intent.

The structure of the seqlock was introduced in commit 27c438f53e79
("nfsd: Support the server resetting the boot verifier").

The NFS write verifier is an 8-byte cookie that is supposed to
indicate the boot epoch of the server -- simply put, when the server
restarts, the epoch (and this verifier) changes.

NFSv3 and later have a two-phase write scheme where the client
sends data to the server (known as an UNSTABLE WRITE), then later
asks the server to commit that data (a COMMIT). Before the COMMIT,
that data is not durable and the client must hold onto it until
the server's COMMIT Reply indicates it's safe for the client to
discard that data and move on.

When an UNSTABLE WRITE is done, the server reports its current
epoch as part of each WRITE Reply. If this verifier cookie changes,
the client knows that the server might have lost previously
written written-but-uncommitted data, so it must send the WRITEs
again in that (rare) case.

NFSD abuses this slightly by changing the write verifier whenever
there is an underlying local write error that might have occurred in
the background (ie, there was no WRITE or COMMIT operation at the
time that the server could use to convey the error back to the
client). This is supposed to trigger clients to send UNSTABLE WRITEs
again to ensure that data is properly committed to durable storage.

The point of the seqlock is to ensure that

a) a write verifier update does not tear the verifier
b) a write verifier read does not see a torn verifier

This is a hot path, so we don't want a full spinlock to achieve
a) and b).

Way back when, the verifier was updated by two separate 32-bit
stores; hence the risk of tearing.


> nfsd_copy_write_verifier() uses read_seqbegin_or_lock() incorrectly.
> "seq" is always even, so read_seqbegin_or_lock() can never take the
> lock for writing. We need to make the counter odd for the 2nd round:
> 
> 	--- a/fs/nfsd/nfssvc.c
> 	+++ b/fs/nfsd/nfssvc.c
> 	@@ -359,11 +359,14 @@ static bool nfsd_needs_lockd(struct nfsd_net *nn)
> 	  */
> 	 void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net *nn)
> 	 {
> 	-	int seq = 0;
> 	+	int seq, nextseq = 0;
> 	 
> 		do {
> 	+		seq = nextseq;
> 			read_seqbegin_or_lock(&nn->writeverf_lock, &seq);
> 			memcpy(verf, nn->writeverf, sizeof(nn->writeverf));
> 	+		/* If lockless access failed, take the lock. */
> 	+		nextseq = 1;
> 		} while (need_seqretry(&nn->writeverf_lock, seq));
> 		done_seqretry(&nn->writeverf_lock, seq);
> 	 }
> 
> OTOH. This function just copies 8 bytes, this makes me think that it doesn't
> need the conditional locking and read_seqbegin_or_lock() at all. So perhaps
> the (untested) patch below makes more sense? Please note that it should not
> change the current behaviour, it just makes the code look correct (and more
> optimal but this is minor).
> 
> Another question is why we can't simply turn nn->writeverf into seqcount_t.
> I guess we can't because nfsd_reset_write_verifier() needs spin_lock() to
> serialise with itself, right?

"reset" is supposed to be very rare operation. Using a lock in that
case is probably quite acceptable, as long as reading the verifier
is wait-free and guaranteed to be untorn.

But a seqcount_t is only 32 bits.


> Oleg.
> ---
> 
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index c7af1095f6b5..094b765c5397 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -359,13 +359,12 @@ static bool nfsd_needs_lockd(struct nfsd_net *nn)
>   */
>  void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net *nn)
>  {
> -	int seq = 0;
> +	unsigned seq;
>  
>  	do {
> -		read_seqbegin_or_lock(&nn->writeverf_lock, &seq);
> +		seq = read_seqbegin(&nn->writeverf_lock);
>  		memcpy(verf, nn->writeverf, sizeof(nn->writeverf));
> -	} while (need_seqretry(&nn->writeverf_lock, seq));
> -	done_seqretry(&nn->writeverf_lock, seq);
> +	} while (read_seqretry(&nn->writeverf_lock, seq));
>  }
>  
>  static void nfsd_reset_write_verifier_locked(struct nfsd_net *nn)
> 

-- 
Chuck Lever
