Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9D26F49A5
	for <lists+linux-nfs@lfdr.de>; Tue,  2 May 2023 20:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbjEBSYC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 May 2023 14:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjEBSYB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 May 2023 14:24:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A66FEC
        for <linux-nfs@vger.kernel.org>; Tue,  2 May 2023 11:23:59 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342INd3P029064;
        Tue, 2 May 2023 18:23:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=qUN2puho59+/VG7Wx5AjNNnqVQniu5QxI7Rru0AiZ/I=;
 b=PACTzknM/iulUXkWed5dhBB+xv6h1Tn5i7W4xxQmyQFOGPq1FAj8FaAPPlrCufd7yDhX
 8nBoJdFYzc3Mab7/hh5vx/S6fSfqCItW+Xyo0SvwpnMO3369AwasCsVewWC+Smh6Rb9P
 VI8PvkMwStbryJYrPeFQGIoDlPX0eXvVFEePW5IdKGrV4w5/Qfgp6jPk9wctvTuSxNR3
 rl3Yaw6PIUNS0N2lrcy6lmQ6GGuaCKqDzUk+C5SnZJx2lyCsi63WVlVNU7tiPpSPRnHK
 49+Ms8+zKVUe5pJPyfU3rP36W0eJQxPQTv84UeWdy+FEwDH7z8wQCJKxA45Desn4oHPR 7A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u9cwj07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 May 2023 18:23:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 342HVOvP027493;
        Tue, 2 May 2023 18:23:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spccsau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 May 2023 18:23:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJ52SjXxQlIxkrUkkBb3P/hnGe6IbsY6GIa0CoXm07gJvUdMmgQZMCdH5u3VkFzXPEe9kcQxA3tCQvnjxsxLrB2/ZcBYSsOgGckX3nVbIx70+9/y11wBIfSQ5Yk6B/OQUQMtzcfgyAnaObxT5X/98q6t+QVklT0OI4ycjwxcrYLbQE/zXklaJ9eLrouzfHw0OSK1WxkTy0HQymhKa3Qm8tRuQ6GiUvRY40pWdTJvt32+w3MiGDrmjYoBvAzH5IlPzqAISazbi/Ygts5hN+LlCIu4aVzKRP6HIZne4lv4t2LGDbkzKOwZUY8uRWbIe3IsY7qs8e/kPjLU3ilkPYkR6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUN2puho59+/VG7Wx5AjNNnqVQniu5QxI7Rru0AiZ/I=;
 b=VaR2hfyjGYItSDUcCTn/dkRrE+oWUFBOrniIiCx/DTwFp0Nak2A54tj9bPoZ8/ec0H51RNpuSvIuXTdX6KRVmlhHGxCiP17+AUvofQdqJHY6d4l61IHSbrnnXogdAZiyvZObJEwZVhxnn6LbjC24xe25B4M1kv9hhmsHHKarg9uGJC3r4u/gOHOwX7wcfoSRmVjrnhiwPD+Ocvgor+RCLKjGqmBuLp2p1WBgWSQnAaY71e9I+AdSfrcyE9gaPUpU8KXkGWakwlwHNjX8L6Hr/i1XnA6GLRXPvUIwS9bq7j67rUgSAhoFM892FWqBWPXX5avl39DmDg6eRy3s2u46QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUN2puho59+/VG7Wx5AjNNnqVQniu5QxI7Rru0AiZ/I=;
 b=oEH4nqE10MPmkBzChoUTdBFk3URj2wf5dxNtxXAHM0asfshDCHly1ttPhEe1K4D1ZGSinLlzZmv8VeH+OAHuUfbdEGiEQA0ZqN1nYQSzXgmGtZO2zqYL8Ipu8yIzqvDqbyq1fvN+Hni9ECxCr30erMgqQLDbkrcY49jM5J2EEdE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6074.namprd10.prod.outlook.com (2603:10b6:208:3ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 18:23:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 18:23:51 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Sherry Yang <sherry.yang@oracle.com>
Subject: Re: [PATCH] nfsd: use vfs setgid helper
Thread-Topic: [PATCH] nfsd: use vfs setgid helper
Thread-Index: AQHZfPsU0hWi9leffEW/mcTC+uI3U69G/7aAgAAykoCAABoxAA==
Date:   Tue, 2 May 2023 18:23:51 +0000
Message-ID: <741D94D5-4058-452E-830B-49D3BEBD5D8E@oracle.com>
References: <20230502-agenda-regeln-04d2573bd0fd@brauner>
 <77C7061E-2316-4C73-89E5-7C8CA0AEB6FD@oracle.com>
 <51805A56-F815-405F-8CDF-4CD04A17436C@oracle.com>
In-Reply-To: <51805A56-F815-405F-8CDF-4CD04A17436C@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB6074:EE_
x-ms-office365-filtering-correlation-id: 2fe1fa3b-b67b-4fee-9a5b-08db4b3a6111
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uyXjztnT9OpwZqMAoAHTGqNtS7MDX/QxFAQfOAiXwcdTA4bVkdYVKJgRtdi3iGKCy0GZAXvhDoYzqlHS3ln5B3opzPa9y/m1ELb1/qKMyuY/ORsinat7V302DCuahZMLCYMYAsTYwhI4PYIbEchUNobZ+85MmV0W1i0tqbyNNXaL8+pgmsjSW+rMegJEIDHJPsx0h93J8btw4KPDTcypBh2V48XrCv8+u9gB8WnIuCua6IoHUZgF8z6jgpdMjWaFqAmoCjWwEyGmjQd4WeZUZcBDsRck+ndTBJOFNbArmnjxrGpwaauMHTIkAAZS1cOx5ObHTNqbbwas/83r+Wbf4oGjfY4/SMWOmF9h+/CU3jKqg3tGcP81FaTqZYzjS4fhDqztN4typ79nQVaNcYDd23m96T8mCiCmObBN0dstOKnovohI8mLwgO+MIxwRY4XEbkjKGToyimbvylhoE14aWsVV2A8tBtb1vFeummGfxhNrgVMDkJqfxyPp9+7ol0r6WIqItlDLMQxGFsVyJPo4gvDO+6pMtTvxmk6njQdYX9V9T8j2rw9ZcYPAgzvd9JmfJ516WB2+/3oVB2rRxCWqaVUpIqjWpzjB8Rpi2TS5WErDwZHzFdy0/8Kvylc3uN6H+5aADMluxXcYpgA/AzNVcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(396003)(136003)(346002)(366004)(451199021)(36756003)(316002)(107886003)(83380400001)(54906003)(91956017)(41300700001)(6486002)(2616005)(71200400001)(33656002)(186003)(6512007)(26005)(6506007)(53546011)(2906002)(5660300002)(38100700002)(4326008)(64756008)(66446008)(66556008)(66476007)(76116006)(122000001)(66946007)(6916009)(8676002)(38070700005)(8936002)(86362001)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wajAO2akZXXrG7hFhUhO1z4wC8uHBFFua7xlggLF60xdx8bFGWjsmPASi8ak?=
 =?us-ascii?Q?lep+cZrneCY+PSWz+jOixoZ7Dv5PJbsoRaA2+QvysLTy5MjOlOIHKpSJS9oA?=
 =?us-ascii?Q?2gtgKRwlZUy0GW9rNCcf34UKKKPKvP5fhPKhZs+KU+JGy/RrEzoxCh+1FNiB?=
 =?us-ascii?Q?ygXxTR92RJH9KI9I70BzyEhIZiMKqKOfwCxuSGfx2w5lnoNVdyqP+Jst/8zw?=
 =?us-ascii?Q?G0QL4/KFqZBwJY4DKbuYcr2r0yMkaLfVZ10Akq/dYwVCUNXDtFY49A3u4XiM?=
 =?us-ascii?Q?bo12fDm5RlDPererXyJf7J3GPJmHmcQyYBMToPO5vQPNeRm+ne7tJcob03ix?=
 =?us-ascii?Q?wFuMsPRoNFO/0vu2q6RzuNR38o1izFXXaDogTlkZMXi8F0q6mDAgPGKUnj/c?=
 =?us-ascii?Q?dC0zEoUD479JWCUMXaDNM5oETtNyLzmey0lE5PQE8vzkDu3gyr8wYPS68pDA?=
 =?us-ascii?Q?ALAi+GCXjyoqjRDm/eKJSiXFpU5BhExGkV+HnIWaJvMtG2r07ehIwfahkXBb?=
 =?us-ascii?Q?wB6ZVPBzAhKQyXcXcCZQME6K8AOtJN/vrPteSfb86CLsHZ2xP5VIGzEbDeOc?=
 =?us-ascii?Q?kFVtMR4C33ep3xsgaVLifKTHy1dyopkYdjMqM0XU29HkPgOBZHrmgAtmqegm?=
 =?us-ascii?Q?gBmiDj6fIlYuwPmR2caPUDJ2gnOacMqLOe1i3ukQua75YNVzn41TPWijhKSb?=
 =?us-ascii?Q?v+JFA6vhYRa50xpzCf2dAKB/Vb9UCymFyPr6JaOog1PN3cqOmQ2mKaIRiH/6?=
 =?us-ascii?Q?CJAnPhGQ9lG3rvSmPIHn4D3vVBX6DrU73KRHFzO/0+oIYX2qMVyJ/OQmplfU?=
 =?us-ascii?Q?kUlyfEeUAiYUAxLv0zLz3jFDrFBiTif99RlUhEI6t+Yww5tCYUcXCJD4qncP?=
 =?us-ascii?Q?90ypUrJA7KEezZtd8KnkgV1s9Sr+p3s0CXOM0tlQrf9iwRaHBZh9Uk8bmCCn?=
 =?us-ascii?Q?tq9j2LTNBnJN3lkX0U+QoUX4NiBXkzF4wLylwbCdjTW2tHgcY2n5w9eSf+N5?=
 =?us-ascii?Q?hKFWC9mGH65Cc50sCtBa78B2TloCAKkxC4e1g4ANVa8KK0BKLf+PajN2+ZfB?=
 =?us-ascii?Q?PHRdpzi3MwQAzrqIsC89g9TTKDGDSjSMMRRYlpA8ZZn72n+s7J5TcjZW5BPT?=
 =?us-ascii?Q?/L29k8y5tm8///SFaMf1Q+PvdocaJ6bwKc0+BXJYzYeFcWfT7SnV7L53IYHN?=
 =?us-ascii?Q?LptpvxvCykG8vSBjVScOl+axk10rGKCVBwp5V+rn1qnZK1ps2Rnl8X+50YIf?=
 =?us-ascii?Q?fdhrbna48lOUqqUMjCrM/+nc4exHtLw6XMohNK+DAxhul451Pt6iyTdaShPf?=
 =?us-ascii?Q?FoJw6DKkR/fLrPRX0gPAi85QRy9PAlIraCklm2Jon64C8WBvClylTe/x7b7e?=
 =?us-ascii?Q?7BJgrjyVKopO5E/FIaOw3SvfC5DpvL/eqLR2COWoxDN+PBW+QnyhsCN7+lqk?=
 =?us-ascii?Q?5ABEzbDX0lxcmppV0nQxTm4l2Z39SxutDbO9F8p6e1hpc28PRc3HOVClphmz?=
 =?us-ascii?Q?D0x7Cy3LnW8XSoghcIbttmJ1TWITTBj2Xvfm8HVHzE36jj3OpMnRyuxxHTKC?=
 =?us-ascii?Q?gA3PKSzzLm/Cpw2jvBNotyMIYRiXSqMLUm7PAYpF1wc41X/gfy12XBs9wVpY?=
 =?us-ascii?Q?3Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9FE85DE0C47A5243A58C240A18BFC269@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lWezNi+AZkYpBbwWjp5oR+a5rJzyaUIK5wO2dvbGouKLhrKHGV1JBhAcBm9bpcWUmgvJMr3MfSFh2q5UM+rhvbwUrT9F/ST9KsmLg9aJG2sCSRs7FwdTnFs/+6DRo/bivqco/km82D+PymGq7idyWzyr5mFuZwzubW2e5+PH1fIQKPTihDKG0oxFV6H9vDb3gNhgQ4GuQavXefxD9XkaKDr2JuTgo241D16H26lzNGPUZ/oICMwgpM0jG1nHMQDECppnhh0hBuCnnrx5KBOh1sbQrVACLm6pwP4AILRWpav7NQiXLj6Nk+WbZQwjnMzCezutU2QQA5OXvAQV++mDYWA1NqHxzAiRK/Q7G6KBNXLWqGX7YCK+B2wdVNyxdNMcWqGDAylQ0WP+tZVppM58VmC/kTOCPBUgfWd+/dEkrXGOMJlYwsFJv1RGjat8jnFyrBMO8Ek16390zTKYYOwlRxqb/X/OvQX8GsGqYcRdq/+U6ftKB87w5en9js2vuGkp9JSZRrhoXu5cecvhWVv1UE4tCLccZTl4RKgtxe/lTlrgDiUHpQTh7KbKtPReGSjbIGUS09iXx3OfLqJY39vgnkL1fci1uVk/wgPWR1FfTLZu+bdCYaea2S9zLWeNlrVjFako9PxUn+xfXAy77NWZAeszACEOt0JWz+3Ix9bK2H4gWHAfRWavveO1bO6CmOQqCAO7O+UWEXJly3Ih+/vGwcTjGxKMbRi6TPlJYoZoV+R03f9Tm+rBEaMyNiF38CQidei6VIUUcGYOwQ4bWpoIV7rOoxM3PF8y66+LaYiBQbI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe1fa3b-b67b-4fee-9a5b-08db4b3a6111
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 18:23:51.1694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nZUbIXADGIn9CThJtk7jXBp6dw0TbO2OUk2jLvfg/Y9zwwGEe5HvPv3WMmeL2y6UUfSLFapEuNONRKvFXMgxcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6074
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_10,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305020159
X-Proofpoint-GUID: If4lTghNuqM8h4N9uVIEXNGtm5v1maGC
X-Proofpoint-ORIG-GUID: If4lTghNuqM8h4N9uVIEXNGtm5v1maGC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 2, 2023, at 12:50 PM, Chuck Lever III <chuck.lever@oracle.com> wro=
te:
>=20
>=20
>=20
>> On May 2, 2023, at 9:49 AM, Chuck Lever III <chuck.lever@oracle.com> wro=
te:
>>=20
>>>=20
>>> On May 2, 2023, at 9:36 AM, Christian Brauner <brauner@kernel.org> wrot=
e:
>>>=20
>>> We've aligned setgid behavior over multiple kernel releases. The detail=
s
>>> can be found in commit cf619f891971 ("Merge tag 'fs.ovl.setgid.v6.2' of
>>> git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping") and
>>> commit 426b4ca2d6a5 ("Merge tag 'fs.setgid.v6.0' of
>>> git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux").
>>> Consistent setgid stripping behavior is now encapsulated in the
>>> setattr_should_drop_sgid() helper which is used by all filesystems that
>>> strip setgid bits outside of vfs proper. Usually ATTR_KILL_SGID is
>>> raised in e.g., chown_common() and is subject to the
>>> setattr_should_drop_sgid() check to determine whether the setgid bit ca=
n
>>> be retained. Since nfsd is raising ATTR_KILL_SGID unconditionally it
>>> will cause notify_change() to strip it even if the caller had the
>>> necessary privileges to retain it. Ensure that nfsd only raises
>>> ATR_KILL_SGID if the caller lacks the necessary privileges to retain th=
e
>>> setgid bit.
>>>=20
>>> Without this patch the setgid stripping tests in LTP will fail:
>>>=20
>>>> As you can see, the problem is S_ISGID (0002000) was dropped on a
>>>> non-group-executable file while chown was invoked by super-user, while
>>>=20
>>> [...]
>>>=20
>>>> fchown02.c:66: TFAIL: testfile2: wrong mode permissions 0100700, expec=
ted 0102700
>>>=20
>>> [...]
>>>=20
>>>> chown02.c:57: TFAIL: testfile2: wrong mode permissions 0100700, expect=
ed 0102700
>>>=20
>>> With this patch all tests pass.
>>>=20
>>> Reported-by: Sherry Yang <sherry.yang@oracle.com>
>>> Signed-off-by: Christian Brauner <brauner@kernel.org>
>>=20
>> There are some similar fstests failures this fix might address.
>>=20
>> I've applied this patch to the nfsd-fixes tree for broader
>> testing.
>=20
> ERROR: modpost: "setattr_should_drop_sgid" [fs/nfsd/nfsd.ko] undefined!
>=20
> Did I apply this patch to the wrong kernel?

setattr_should_drop_sgid() is not available to callers built as
modules. It needs an EXPORT_SYMBOL or _GPL.


>> Thanks, Christian and Sherry!
>>=20
>>=20
>>> ---
>>> ubuntu@imp1-vm:~/ltp-install$ sudo ./runltp -d /mnt -s chown02
>>> INFO: ltp-pan reported all tests PASS
>>> LTP Version: 20230127-112-gf41e8a2fa
>>>=20
>>> ubuntu@imp1-vm:~/ltp-install$ sudo ./runltp -d /mnt -s fchown02
>>> INFO: ltp-pan reported all tests PASS
>>> LTP Version: 20230127-112-gf41e8a2fa
>>>=20
>>> ubuntu@imp1-vm:~/src/git/xfstests$ sudo ./check -g perms
>>> FSTYP         -- nfs
>>> PLATFORM      -- Linux/x86_64 imp1-vm 6.3.0-nfs-setgid-3a3cfe624076 #20=
 SMP PREEMPT_DYNAMIC Tue May  2 12:35:51 UTC 2023
>>> MKFS_OPTIONS  -- 127.0.0.1:/nfsscratch
>>> MOUNT_OPTIONS -- -o vers=3D3,noacl 127.0.0.1:/nfsscratch /mnt/scratch
>>> Passed all 41 tests
>>> ---
>>> fs/nfsd/vfs.c | 4 +++-
>>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>>=20
>>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>>> index bb9d47172162..c4ef24c5ffd0 100644
>>> --- a/fs/nfsd/vfs.c
>>> +++ b/fs/nfsd/vfs.c
>>> @@ -388,7 +388,9 @@ nfsd_sanitize_attrs(struct inode *inode, struct iat=
tr *iap)
>>> iap->ia_mode &=3D ~S_ISGID;
>>> } else {
>>> /* set ATTR_KILL_* bits and let VFS handle it */
>>> - iap->ia_valid |=3D (ATTR_KILL_SUID | ATTR_KILL_SGID);
>>> + iap->ia_valid |=3D ATTR_KILL_SUID;
>>> + iap->ia_valid |=3D
>>> + setattr_should_drop_sgid(&nop_mnt_idmap, inode);
>>> }
>>> }
>>> }
>>> --=20
>>> 2.34.1
>>>=20
>>=20
>> --
>> Chuck Lever
>=20
>=20
> --
> Chuck Lever


--
Chuck Lever


