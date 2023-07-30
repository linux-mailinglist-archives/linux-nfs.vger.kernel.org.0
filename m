Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F30768944
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Jul 2023 01:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjG3XTi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 30 Jul 2023 19:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjG3XTh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 30 Jul 2023 19:19:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CFC11B
        for <linux-nfs@vger.kernel.org>; Sun, 30 Jul 2023 16:19:35 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36UMeTH5005035;
        Sun, 30 Jul 2023 23:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=JJl280+nEVQS7G5/6dAYtDgn4l5c8y21u4Gbhdl3Dl8=;
 b=qnKDkJvGDEr6N0cjExNQW/6t32sPQPY6LnYdYAFabRILhevLhQ0fKSsowmArXtGUC/Kd
 YqsV/P/LcKJZ7jVfNiqgcq0+N2M0Lxw946degSWAlnMyRrMAbAdcBmadSYTHD6ypyUuJ
 uLrJO4dnjdZJbCeMQgomjAd0lcRA5gv9ttUKvZpvQtStpFiPXNb17fzipHfvI9E6HJLh
 X2pUJrIWE7Jjnpofa+2HC7hPdn0UmDH+c79C7S1tnh9u/rlWhIPGPzdIbJhLK/mS4ypy
 AUQmmpr7wxEGq2rO46f2U+N6KCitstTHJLBQ+ddF63qXsUF83mPLS43s6GfekSwVeh2a MQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4uausekq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Jul 2023 23:19:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36UI5tl7000660;
        Sun, 30 Jul 2023 23:19:23 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s73ntk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Jul 2023 23:19:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Td7pVRYyRJBqKXE06vzxgMPKrdbykz6kkfxSNJVxwPU4zrdAhsXgPu6ZjBm4PUH/PuRTIYHBKYYI9+EUlvXZgXbFftUTTXbkG9ZR054veVbb49EsTK6HUQR8+787INYoYrPb7wuMPkE+947ZPZRJ6BBJf+NB0dmf6pDn2xh3wj9EpUFmCUkfnYKBIZDiTSiRwGTImwOs5IPcpnmlqK6USgb1da28EO8jRKTyc+7AfmGhGSRJCEjtznx8+h2/nwFmELKO1OFRJECzmIvfBK1YRUrMK7HMHQzWbBStCqLFh/R25JSnnI295BBfTsQyo2yRdOmTxiAjtCPIUWGc5GRajA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJl280+nEVQS7G5/6dAYtDgn4l5c8y21u4Gbhdl3Dl8=;
 b=kyXduQTaqHW6S5btC+nWcrIQWeqtwEKXmXtuBIrBNTJngPBlFoB8C3t5+m2CuI/vQfOGK7zFNsvM0whz7SgRmnrecq3r/OyUPRG1UL92qmFfPV/bXEsRXbpSjhmxQ9flTqups1Khh5BD6+hdAnzVcPaxqmkdX0U0RDG71i2oJOeHSjpbpBjkFPHhn0ir0DbwCE6mdHwR4j0cKU+gY5j1fzoOWbRNB7EhYRaPonvMpiYTldDL3eN1SI29IL3YzFwIt68ETUP83UZTD0kme6gbVraEa4U/k6PSRp3cQDPJReTrZFLhkhxSfUOCLG+E3FKfii6GhFuHf+eKI+NvwVzfpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJl280+nEVQS7G5/6dAYtDgn4l5c8y21u4Gbhdl3Dl8=;
 b=jECk9C6MMPXqRO7Wk9AXfh8krlv6RiE/WI1GkUDRjv73LLIkgB8jFf4JhAKS5PzWZ/deYxTxyKt+GCJNSozh+SngZxuoAJql8PEJEStOCSlFJLRy7p5OxIQQtn+EZXr/AWXseh+tOI2cyGrDXFr7OTTLhaDgVjA0FtxrLnADKhM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4266.namprd10.prod.outlook.com (2603:10b6:5:210::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Sun, 30 Jul
 2023 23:19:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6631.042; Sun, 30 Jul 2023
 23:19:20 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 06/14] SUNRPC: change various server-side #defines to enum
Thread-Topic: [PATCH 06/14] SUNRPC: change various server-side #defines to
 enum
Thread-Index: AQHZuUKeUhPN688TTEazI3MFmgB5Iq+/h5sAgBMC4QCAAHt6gA==
Date:   Sun, 30 Jul 2023 23:19:20 +0000
Message-ID: <39A12B38-C1D1-4112-8C91-CCFE329342D7@oracle.com>
References: <168966227838.11075.2974227708495338626.stgit@noble.brown>
 <168966228863.11075.8173252015139876869.stgit@noble.brown>
 <ZLaVtpLf1k2Ig5Kz@bazille.1015granger.net>
 <ZMaIWPyEm83GaS0q@tissot.1015granger.net>
In-Reply-To: <ZMaIWPyEm83GaS0q@tissot.1015granger.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM6PR10MB4266:EE_
x-ms-office365-filtering-correlation-id: cc4c3a1c-16eb-405b-59fc-08db9153675a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j5tRAGg4Ll2H/Iu148wYhMxc2wbz9o8nxCRnHdaqVICGEe8/MTJ6erZUPdTDScdigq3mQ7lJWK3SN1ciawHYuFGcoKARgDBOBBHWIDfb9DCU/7GFsK/RGKgwh9Hi93xvANHp1+r2RVSFsEb2p+RVWOuQ+uIEeItBG6WDGimq9rS1G09As39Gtrh7KQh/sgTGQRzzAWOpscP1jCtCjSRaYoFUCfWxJD+FK0VC6mP6lW5oxrPt77usIUZfLMY1QaU6g0NT/34EPnhv2M1IoLoGh90cwtK6nffznQkiReQW4cvVhbVsaeW5DrGqHcFdc27HNNTZ8dpnDqTLxb7Pq5Ky/LEU8plWve7h1u/27kdZt4ZJTgu+fcFfz1o4Ix7X9FmyhRpukAXNBYTbrZvjf0iEkxJDCKZu2Uti03qc02MH8E6mk9pJTuL3V/OeF7gAj8epkmhnQm3TPmqWsieZDo4+tpcFkHG+iqtqgMfNkbC1Vm2ok4Au0wibC5MRNeED2HWwagUpBO/Kq1fwn7pXkvAQgocdvAIlXof64/yuYSs4I54rSdus/NNrexqEcjr8Dy9JTOTmf6WeCFM7ybGRKWp75p5ahLtHvjEn8soGG79cbn+gG2vsdEMQTEugXQXd6YJ+s3gnROizTVBaBqrf9AseDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199021)(2616005)(5660300002)(6506007)(53546011)(8936002)(8676002)(186003)(83380400001)(26005)(478600001)(316002)(76116006)(91956017)(66946007)(6916009)(54906003)(4326008)(66556008)(66476007)(66446008)(64756008)(6486002)(71200400001)(6512007)(41300700001)(86362001)(33656002)(38070700005)(36756003)(2906002)(30864003)(38100700002)(122000001)(66899021)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5cohF81T/NCJMPPcyMgrZUtfRVmjPYs8XGgGynhWwMw41oFU82xgpjwL0VNv?=
 =?us-ascii?Q?4xuv4uwGMzjeZ955yPQ61B0lYwXstcdkQPif2Yunbv0RoYDRg66WRzTIdVNK?=
 =?us-ascii?Q?+0So3u7bwGpclsh5KWd7Y8u3YRZOSYrfWRRKva3AtccPb8uL7zB0W96c9f75?=
 =?us-ascii?Q?ZCeIKYL3Teg6LGA36RILJPJ24ZHbbp50kP0vjUwrQuOC+Yy4JSoAIln2Bz4n?=
 =?us-ascii?Q?mMVy83iLSGaiD4FbKbm88b7giPG0J4wlQ9fYDXq4BV/LKdqJtGiHZ8SDn84X?=
 =?us-ascii?Q?Pd2zX9bDbn2Q9XaSMk+w5XxemHjQzvJdo2gvPovQFYaheCEttUTs4CP2iLT9?=
 =?us-ascii?Q?h0q6hcrM7ypN0jpPA2RtlboUYHbt3v3nVc7BJI4TLkknyQgi4k8zLEW6cyf6?=
 =?us-ascii?Q?Qg5tzWVeYh/n4WeSHqlcDc5h29GhOXO58EVv4d+Ky/1fIytHsHxuLgozTRKP?=
 =?us-ascii?Q?JX8dCjWFrS5GBL9O/505u93b8SQ62FzCYxQ0ISQMKRXXnGFSxDi1HIJs8319?=
 =?us-ascii?Q?BY3k2k9T1/EXwckEKcfowc5nwQ6TNuKISAseKL2OtOuK5cd9cf0JsnMRDzzV?=
 =?us-ascii?Q?QmO6raBrpWYrb0OzXXvBqDw59NhFuFf4MHmWOsZgU4OmBCRdGRgseEuZ69ov?=
 =?us-ascii?Q?i3mMbzpFY9bFcIGbE0mb7drnM8rKXnU/4F9xasT7clkzchpTAn5CEMbGZC5u?=
 =?us-ascii?Q?HjCNFckv/U/H6qOCQHkzi9fmBMhXD23mYkCje7rtYemlNMoDVE1dk/KtT2Z6?=
 =?us-ascii?Q?SK0eBmnDiSzDl4yqkzb3zegwzLMimP15SUz8Vc9D/XanLhcvRdA51vovy5sQ?=
 =?us-ascii?Q?KuXSQkptanhl9L3hgPpXscH09yP6rlXr3qld88DiidV3XP+xwoW5fkV04sni?=
 =?us-ascii?Q?LbsSflvNKcZ2qPXsWNq2umKJcPn/KzhH0HiZWCP1FK15Bueidcpx9guJHQFt?=
 =?us-ascii?Q?0nGsJLaoIa4y6qhHMRNweIJIGovGokfZrUfFX2bjTFNEGPMqMPd0PFcyVEu+?=
 =?us-ascii?Q?AL3xFAUKVtDqUV1rm23MbC8TAgEsoFrjwbkt9KKLjNsX2VowyUz2f77je01d?=
 =?us-ascii?Q?00pNzHElHFdVw6xhKeez7CCqfWN00UrHglIcXGNNFk6fTbEVN5zom3bUxv8B?=
 =?us-ascii?Q?M1XdudMonfSvDHm47SucF/KW2ByfX64QUvrRn5xVFuYRH2VWYUrBMOzP4SUB?=
 =?us-ascii?Q?mgmQKA0HDyDgU5YSnDllkgFnYZwo9mT6Wmjewz0khFx0FDWU3U2bHsbErt6d?=
 =?us-ascii?Q?gk3M6Y3VTBUM9cmmZEIUzbI39g52XecRmBmuY7r2M28b3ue0RUEpX9l4TUnX?=
 =?us-ascii?Q?xwim97Z5bHrAMdzBVw2Q0Qk9UJrkwoaPpJU991KbqorkLm+7ZGXm4J19qSpI?=
 =?us-ascii?Q?qMu26in2sn7UiKGyCgvWyGqYM+NdBZ24/bp5cXJSXkwAAunE1xVk7B1PAk+c?=
 =?us-ascii?Q?XvMjHZVRjCMv1lZJu9FydEUeZpSHThjpMEiWOYN4uD4cYoxbbCUPzhRxI1OA?=
 =?us-ascii?Q?79aimfHR0U6MpbVDqdCm9Szv3TEnMFCzVJBw6zd/ZK3/B/CEnqbdc+vH8PoG?=
 =?us-ascii?Q?nWg9hAgbaOjIeaxKuItREk6otEHzFb30bJ9NqCG8P0lI7HeobpjV3H9RlF4J?=
 =?us-ascii?Q?vw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <87DDF24318BAF3498FC56ACEFCC25BD7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hASLCSl6Lrb9JXwyu4TxXF1YWaQSv/cwlqV/HfuCqa33zL98qzRH1biuXX70+My1Yf67jSZBCP2IUJattUe2WDMbDYYWgX4ImKy9nEZnPODeo9CvN/QqIFktFgPXwhZ1D/WuVCjUNde1INHn7/u0qEhctDk+zqWCkwEIxrfjO9Xo6NjHD+MdiAvwU86JN4sALgbTPZoOo/hwEOX0AJHnhhAK+9Vxs7NvVza9lfRz6CfeqUxZaytAqcayadIg1RUDGkuwixedHHvhOMMVuHyO85T5YKe1Hw7tCbyVP8a4a90ZeG/UeO3FSqnY8A0xaT9XIgNUpDrLQUSKZhDob2ctYxCOPS/H3cjgZItCTvR66h9X2FZ20wB35YmGtKEI42fDsThgGCXfr4zeHN1Fqvwvu4TAuED9CLKMG673zGyGby8LF7jPiAsHjZHMPze0XRTQW5AC6+AocCSAtXHhIghGnixHMAzUCBbKaEI4D2cnpEizVcmyVPa6RPzlhIsYJluhQ16hEtew5/hLSkSOs23HVhYnKkCxsMPGpt5SKR+PwyVS9Vq+D3zMos9oSyUkyG0PH1w4SiATbi6XYiaABhhYBaYP3nobrx0krxbsKu5QNbAijYpOtUn7UMyu+W+MkEABzgjUHWbjLh6z9+eLm+zB3OyEoQGeB+mSpW4k/mAtLV4ACmPYPRzwhmqGjgBfYoJ3jHuRq9fkOwejB0lSSAyYfFxVVAx8mY76i7GJyqsEQMnBZRpsKHOPVzhCCT9OyivzTbaBvc1/+W3sGTx7MU7qzrG2L+mINZ+uSSeNsqPsn4Qcm4Kobxx2NfbmQsMtY3mC
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4c3a1c-16eb-405b-59fc-08db9153675a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2023 23:19:20.4774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2871cC9675l9LrBJ6Nj9cUF0SSSbUz/vUYUPl520EFAUb2kO0aKmqdk3jopJg8klMzXAcOjZY25c75Hp0J6ysQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4266
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307300218
X-Proofpoint-ORIG-GUID: WiB5IOaXf5r5KQwiu3CR4G0oW9_7bQnE
X-Proofpoint-GUID: WiB5IOaXf5r5KQwiu3CR4G0oW9_7bQnE
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 30, 2023, at 11:57 AM, Chuck Lever <chuck.lever@oracle.com> wrote:
>=20
> On Tue, Jul 18, 2023 at 09:37:58AM -0400, Chuck Lever wrote:
>> On Tue, Jul 18, 2023 at 04:38:08PM +1000, NeilBrown wrote:
>>> When a sequence of numbers are needed for internal-use only, an enum is
>>> typically best.  The sequence will inevitably need to be changed one
>>> day, and having an enum means the developer doesn't need to think about
>>> renumbering after insertion or deletion.  The patch will be easier to
>>> review.
>>=20
>> Last sentence needs to define the antecedant of "The patch".
>=20
> I've changed the last sentence in the description to "Such patches
> will be easier ..."
>=20
> I've applied 1/5 through 5/5, with a few cosmetic changes, to the
> SUNRPC threads topic branch. 6/6 needed more work:
>=20
> I've split this into one patch for each new enum.
>=20
> The XPT_ flags change needed TRACE_DEFINE_ENUM macros to make
> show_svc_xprt_flags() work properly. Added.
>=20
> The new enum for SVC_GARBAGE and friends... those aren't bit flags.
> So I've made that a named enum so that it can be used for type-
> checking function return values properly.
>=20
> I dropped the hunk that changes XPRT_SOCK_CONNECTING and friends.
> That should be submitted separately to Anna and Trond.
>=20
> All this will appear in the nfsd repo later today.

I just pushed these changes to topic-sunrpc-thread-scheduling.


>>> Signed-off-by: NeilBrown <neilb@suse.de>
>>> ---
>>> include/linux/sunrpc/cache.h    |   11 +++++++----
>>> include/linux/sunrpc/svc.h      |   34 ++++++++++++++++++++------------=
--
>>> include/linux/sunrpc/svc_xprt.h |   39 +++++++++++++++++++++-----------=
-------
>>> include/linux/sunrpc/svcauth.h  |   29 ++++++++++++++++-------------
>>> include/linux/sunrpc/xprtsock.h |   25 +++++++++++++------------
>>> 5 files changed, 77 insertions(+), 61 deletions(-)
>>>=20
>>> diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.=
h
>>> index 518bd28f5ab8..3cc4f4f0c764 100644
>>> --- a/include/linux/sunrpc/cache.h
>>> +++ b/include/linux/sunrpc/cache.h
>>> @@ -56,10 +56,13 @@ struct cache_head {
>>> struct kref ref;
>>> unsigned long flags;
>>> };
>>> -#define CACHE_VALID 0 /* Entry contains valid data */
>>> -#define CACHE_NEGATIVE 1 /* Negative entry - there is no match for the=
 key */
>>> -#define CACHE_PENDING 2 /* An upcall has been sent but no reply receiv=
ed yet*/
>>> -#define CACHE_CLEANED 3 /* Entry has been cleaned from cache */
>>> +/* cache_head.flags */
>>> +enum {
>>> + CACHE_VALID, /* Entry contains valid data */
>>> + CACHE_NEGATIVE, /* Negative entry - there is no match for the key */
>>> + CACHE_PENDING, /* An upcall has been sent but no reply received yet*/
>>> + CACHE_CLEANED, /* Entry has been cleaned from cache */
>>> +};
>>=20
>> Weird comment of the day: Please use a double-tab before the comments
>> to leave room for larger flag names in the future.
>>=20
>>=20
>>> #define CACHE_NEW_EXPIRY 120 /* keep new things pending confirmation fo=
r 120 seconds */
>>>=20
>>> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
>>> index f3df7f963653..83f31a09c853 100644
>>> --- a/include/linux/sunrpc/svc.h
>>> +++ b/include/linux/sunrpc/svc.h
>>> @@ -31,7 +31,7 @@
>>>  * node traffic on multi-node NUMA NFS servers.
>>>  */
>>> struct svc_pool {
>>> - unsigned int sp_id;     /* pool id; also node id on NUMA */
>>> + unsigned int sp_id; /* pool id; also node id on NUMA */
>>> spinlock_t sp_lock; /* protects all fields */
>>> struct list_head sp_sockets; /* pending sockets */
>>> unsigned int sp_nrthreads; /* # of threads in pool */
>>> @@ -44,12 +44,15 @@ struct svc_pool {
>>> struct percpu_counter sp_threads_starved;
>>> struct percpu_counter sp_threads_no_work;
>>>=20
>>> -#define SP_TASK_PENDING (0) /* still work to do even if no
>>> - * xprt is queued. */
>>> -#define SP_CONGESTED (1)
>>> unsigned long sp_flags;
>>> } ____cacheline_aligned_in_smp;
>>>=20
>>> +/* bits for sp_flags */
>>> +enum {
>>> + SP_TASK_PENDING, /* still work to do even if no xprt is queued */
>>> + SP_CONGESTED, /* all threads are busy, none idle */
>>> +};
>>> +
>>> /*
>>>  * RPC service.
>>>  *
>>> @@ -232,16 +235,6 @@ struct svc_rqst {
>>> u32 rq_proc; /* procedure number */
>>> u32 rq_prot; /* IP protocol */
>>> int rq_cachetype; /* catering to nfsd */
>>> -#define RQ_SECURE (0) /* secure port */
>>> -#define RQ_LOCAL (1) /* local request */
>>> -#define RQ_USEDEFERRAL (2) /* use deferral */
>>> -#define RQ_DROPME (3) /* drop current reply */
>>> -#define RQ_SPLICE_OK (4) /* turned off in gss privacy
>>> - * to prevent encrypting page
>>> - * cache pages */
>>> -#define RQ_VICTIM (5) /* about to be shut down */
>>> -#define RQ_BUSY (6) /* request is busy */
>>> -#define RQ_DATA (7) /* request has data */
>>> unsigned long rq_flags; /* flags field */
>>> ktime_t rq_qtime; /* enqueue time */
>>>=20
>>> @@ -272,6 +265,19 @@ struct svc_rqst {
>>> void ** rq_lease_breaker; /* The v4 client breaking a lease */
>>> };
>>>=20
>>> +/* bits for rq_flags */
>>> +enum {
>>> + RQ_SECURE, /* secure port */
>>> + RQ_LOCAL, /* local request */
>>> + RQ_USEDEFERRAL, /* use deferral */
>>> + RQ_DROPME, /* drop current reply */
>>> + RQ_SPLICE_OK, /* turned off in gss privacy to prevent encrypting page
>>> + * cache pages */
>>> + RQ_VICTIM, /* about to be shut down */
>>> + RQ_BUSY, /* request is busy */
>>> + RQ_DATA, /* request has data */
>>> +};
>>> +
>>=20
>> Also here -- two tab stops instead of one.
>>=20
>>=20
>>> #define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : rqst->r=
q_bc_net)
>>>=20
>>> /*
>>> diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc=
_xprt.h
>>> index a6b12631db21..af383d0349b3 100644
>>> --- a/include/linux/sunrpc/svc_xprt.h
>>> +++ b/include/linux/sunrpc/svc_xprt.h
>>> @@ -56,26 +56,9 @@ struct svc_xprt {
>>> struct list_head xpt_list;
>>> struct list_head xpt_ready;
>>> unsigned long xpt_flags;
>>> -#define XPT_BUSY 0 /* enqueued/receiving */
>>> -#define XPT_CONN 1 /* conn pending */
>>> -#define XPT_CLOSE 2 /* dead or dying */
>>> -#define XPT_DATA 3 /* data pending */
>>> -#define XPT_TEMP 4 /* connected transport */
>>> -#define XPT_DEAD 6 /* transport closed */
>>> -#define XPT_CHNGBUF 7 /* need to change snd/rcv buf sizes */
>>> -#define XPT_DEFERRED 8 /* deferred request pending */
>>> -#define XPT_OLD 9 /* used for xprt aging mark+sweep */
>>> -#define XPT_LISTENER 10 /* listening endpoint */
>>> -#define XPT_CACHE_AUTH 11 /* cache auth info */
>>> -#define XPT_LOCAL 12 /* connection from loopback interface */
>>> -#define XPT_KILL_TEMP   13 /* call xpo_kill_temp_xprt before closing *=
/
>>> -#define XPT_CONG_CTRL 14 /* has congestion control */
>>> -#define XPT_HANDSHAKE 15 /* xprt requests a handshake */
>>> -#define XPT_TLS_SESSION 16 /* transport-layer security established */
>>> -#define XPT_PEER_AUTH 17 /* peer has been authenticated */
>>>=20
>>> struct svc_serv *xpt_server; /* service for transport */
>>> - atomic_t         xpt_reserved; /* space on outq that is rsvd */
>>> + atomic_t xpt_reserved; /* space on outq that is rsvd */
>>> atomic_t xpt_nr_rqsts; /* Number of requests */
>>> struct mutex xpt_mutex; /* to serialize sending data */
>>> spinlock_t xpt_lock; /* protects sk_deferred
>>> @@ -96,6 +79,26 @@ struct svc_xprt {
>>> struct rpc_xprt *xpt_bc_xprt; /* NFSv4.1 backchannel */
>>> struct rpc_xprt_switch *xpt_bc_xps; /* NFSv4.1 backchannel */
>>> };
>>> +/* flag bits for xpt_flags */
>>> +enum {
>>> + XPT_BUSY, /* enqueued/receiving */
>>> + XPT_CONN, /* conn pending */
>>> + XPT_CLOSE, /* dead or dying */
>>> + XPT_DATA, /* data pending */
>>> + XPT_TEMP, /* connected transport */
>>> + XPT_DEAD, /* transport closed */
>>> + XPT_CHNGBUF, /* need to change snd/rcv buf sizes */
>>> + XPT_DEFERRED, /* deferred request pending */
>>> + XPT_OLD, /* used for xprt aging mark+sweep */
>>> + XPT_LISTENER, /* listening endpoint */
>>> + XPT_CACHE_AUTH, /* cache auth info */
>>> + XPT_LOCAL, /* connection from loopback interface */
>>> + XPT_KILL_TEMP, /* call xpo_kill_temp_xprt before closing */
>>> + XPT_CONG_CTRL, /* has congestion control */
>>> + XPT_HANDSHAKE, /* xprt requests a handshake */
>>> + XPT_TLS_SESSION, /* transport-layer security established */
>>> + XPT_PEER_AUTH, /* peer has been authenticated */
>>> +};
>>>=20
>>> static inline void unregister_xpt_user(struct svc_xprt *xpt, struct svc=
_xpt_user *u)
>>> {
>>> diff --git a/include/linux/sunrpc/svcauth.h b/include/linux/sunrpc/svca=
uth.h
>>> index 6d9cc9080aca..8d1d0d0721d2 100644
>>> --- a/include/linux/sunrpc/svcauth.h
>>> +++ b/include/linux/sunrpc/svcauth.h
>>> @@ -133,19 +133,22 @@ struct auth_ops {
>>> int (*set_client)(struct svc_rqst *rq);
>>> };
>>>=20
>>> -#define SVC_GARBAGE 1
>>> -#define SVC_SYSERR 2
>>> -#define SVC_VALID 3
>>> -#define SVC_NEGATIVE 4
>>> -#define SVC_OK 5
>>> -#define SVC_DROP 6
>>> -#define SVC_CLOSE 7 /* Like SVC_DROP, but request is definitely
>>> - * lost so if there is a tcp connection, it
>>> - * should be closed
>>> - */
>>> -#define SVC_DENIED 8
>>> -#define SVC_PENDING 9
>>> -#define SVC_COMPLETE 10
>>> +/*return values for svc functions that analyse request */
>>> +enum {
>>> + SVC_GARBAGE,
>>> + SVC_SYSERR,
>>> + SVC_VALID,
>>> + SVC_NEGATIVE,
>>> + SVC_OK,
>>> + SVC_DROP,
>>> + SVC_CLOSE, /* Like SVC_DROP, but request is definitely
>>> + * lost so if there is a tcp connection, it
>>> + * should be closed
>>> + */
>>> + SVC_DENIED,
>>> + SVC_PENDING,
>>> + SVC_COMPLETE,
>>> +};
>>>=20
>>> struct svc_xprt;
>>>=20
>>> diff --git a/include/linux/sunrpc/xprtsock.h b/include/linux/sunrpc/xpr=
tsock.h
>>> index 700a1e6c047c..1ed2f446010b 100644
>>> --- a/include/linux/sunrpc/xprtsock.h
>>> +++ b/include/linux/sunrpc/xprtsock.h
>>> @@ -81,17 +81,18 @@ struct sock_xprt {
>>> };
>>>=20
>>> /*
>>> - * TCP RPC flags
>>> + * TCP RPC flags in ->sock_state
>>>  */
>>> -#define XPRT_SOCK_CONNECTING 1U
>>> -#define XPRT_SOCK_DATA_READY (2)
>>> -#define XPRT_SOCK_UPD_TIMEOUT (3)
>>> -#define XPRT_SOCK_WAKE_ERROR (4)
>>> -#define XPRT_SOCK_WAKE_WRITE (5)
>>> -#define XPRT_SOCK_WAKE_PENDING (6)
>>> -#define XPRT_SOCK_WAKE_DISCONNECT (7)
>>> -#define XPRT_SOCK_CONNECT_SENT (8)
>>> -#define XPRT_SOCK_NOSPACE (9)
>>> -#define XPRT_SOCK_IGNORE_RECV (10)
>>> -
>>> +enum {
>>> + XPRT_SOCK_CONNECTING,
>>> + XPRT_SOCK_DATA_READY,
>>> + XPRT_SOCK_UPD_TIMEOUT,
>>> + XPRT_SOCK_WAKE_ERROR,
>>> + XPRT_SOCK_WAKE_WRITE,
>>> + XPRT_SOCK_WAKE_PENDING,
>>> + XPRT_SOCK_WAKE_DISCONNECT,
>>> + XPRT_SOCK_CONNECT_SENT,
>>> + XPRT_SOCK_NOSPACE,
>>> + XPRT_SOCK_IGNORE_RECV,
>>> +};
>>> #endif /* _LINUX_SUNRPC_XPRTSOCK_H */
>>>=20
>>>=20
>>=20
>> Let's not change client-side code in this patch. Please split this
>> hunk out and send it to Trond and Anna separately.
>>=20
>=20
> --=20
> Chuck Lever

--
Chuck Lever


