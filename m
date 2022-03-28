Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B774E98FC
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Mar 2022 16:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240223AbiC1OKZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Mar 2022 10:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239195AbiC1OKY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Mar 2022 10:10:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FC325292
        for <linux-nfs@vger.kernel.org>; Mon, 28 Mar 2022 07:08:43 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22SCtwsT013590;
        Mon, 28 Mar 2022 14:08:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+N3nwIeBtNDPl+iNjfNa5jPIAdjDbO5HiMDAFI8r8dk=;
 b=I5rWg6vR/JBfmuppPpCqdhpum26eybrzL2bFkqAGHbL2lhwpxbsubtZXk530wotSysop
 iqnyX9L/NbNjkDEPBUfcWW8xxPYfZPijcPLrEATowSxjE68YJRUBlWdRzNyd6RsnZ5vh
 O3kLFTqMx3aGA2QG2H3Z/eSFDH+/DcG2cCTGjSd9HXDZHL5oQkwVU8ZJGeoFd0WRZgvv
 h+LhiT909DUPL2GLU0Gh9xmEZt3WbWlGk08ErpPp70NTStlFQjm8vBnCBSpw59Y457jo
 HnFYeaohKYYy8/ZqkFhGwRBMl/M0KQg+iqOCuNZ63OMmxqGu+kkNnMxjlpIjMTeUpze/ Vg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1se0bqy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Mar 2022 14:08:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22SE6c6P077789;
        Mon, 28 Mar 2022 14:08:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by aserp3020.oracle.com with ESMTP id 3f1tmyga7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Mar 2022 14:08:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQU2jLhq/VvfTDArUIA9VbcfeItI4jHf/tbSKmb1NdsqM6tiAQz2pRq8Az5RUBVW/Uu9uD4ebXln4cnhg3HDzyIF53Zpy7pT9lV8W94bv3yMCmzfEtCKfSlr7wdtwoIFv7pVZrhGZKsCGhZXKgWOfCPkY1u2nVkSIq+db6qQBVLLAl6uP7TcUULMwBnQACWTRMPPwRKsgnJMRx4AmM65eClM1Irlpb7nQM+WdkuAr7Gcfc2Vfh+JSL04/eYRobdaW03uAWJMQ94ajimSQE6oD8Fg//ODqinKHZabv2UQzBYjPCy9IVTxh281nlGUdXEX8vG2lnD6FHHDANyys5pqMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+N3nwIeBtNDPl+iNjfNa5jPIAdjDbO5HiMDAFI8r8dk=;
 b=JRO0vFQ4ecWHIC+wCOvrqCeBnhfesxa92jR+N/VW9I9Ib7EpmE60Qaq96lyO01/Z+h0uhsmB9bdn/sDVafyKk/1Z/5Xz3ysWsf3LcDaZkmgIHxEu4NBuf1VXXs4thcVwftJ08CO2jxnomjka4hVUn7d/2AChwqV9xFJFHRdq3W6uKd/MxHYpEJUlEUHajkIKUTfw163k1EGY1OFdpmCyMrmZD57Qnm7JB5HCdQWXOPziqOsKBxw5HFSdbqZXWwc+QTnRo/PJG/sH1vZ+OwRQeKN2m0Myq6yOq5vzXx9uxsZ5qoZsDG2m/ZQho4aldEa0+0YscZx/3kzYv589TKgM/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+N3nwIeBtNDPl+iNjfNa5jPIAdjDbO5HiMDAFI8r8dk=;
 b=JgeFhob4MZ1jU3NLsQDNV38tDfNx4da4Z1fhFUr/+KVAiMpJtQkZaiWJ8bbzUdM357FpXlQo9yYZ2vegClrsNiZ+ukMN0U2KNJL84dHFeLu7zdwySo35F2hEZMjRuhJAZu3sI0JnMA+X5S2vyg9jOCk8kmfHg3JAh0cfF8wSJ3U=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MWHPR10MB1807.namprd10.prod.outlook.com (2603:10b6:300:109::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Mon, 28 Mar
 2022 14:08:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0%7]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 14:08:31 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Benjamin Coddington <bcodding@redhat.com>,
        Steve Dickson <SteveD@RedHat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH/RFC] NFSv4: ensure different netns do not share
 cl_owner_id
Thread-Topic: [PATCH/RFC] NFSv4: ensure different netns do not share
 cl_owner_id
Thread-Index: AQHYP97BJY9z/7BNhkSUi9ed5RyvFKzQM/sAgAQF9ICAAKDvgA==
Date:   Mon, 28 Mar 2022 14:08:31 +0000
Message-ID: <A526C0BA-D123-4A32-BB85-E82D5494043B@oracle.com>
References: <164816787898.6096.12819715693501838662@noble.neil.brown.name>
 <CC04FF50-B936-456D-8BF0-4BF04647B4BC@oracle.com>
 <164844195133.6096.11388357137493699567@noble.neil.brown.name>
In-Reply-To: <164844195133.6096.11388357137493699567@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09814769-4791-4be2-2b48-08da10c470bc
x-ms-traffictypediagnostic: MWHPR10MB1807:EE_
x-microsoft-antispam-prvs: <MWHPR10MB18072E0330FEEEED68794DE3931D9@MWHPR10MB1807.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Orkwi8yGxM/lUnwWkPE+lnt1uU+BqIHTb7dbgXZrzmnoJUg8kgj+whTgX9y2b4vr7kNHpORU2yuDiNcP/vjdgdxgIlVuoZ5IWZV2Pv5+BwKgSRQ/5tBhhnkpuvtcMNn+sxDwAaJDaU9Z55vdEZLwXh6dODpnZ5Xrr8f5BZqCOtEfYAB2BJiUNq9bIMmX9UlQ4vcD2gZ/e1UVqKA8jsFyujmQNYC5VGH9l9BIpS08PkJFw1V1+Bq9oAyN+OJWtam7zlA3mLxAsj1exTxhPISDTEC3gRF1QjtOvnv6NoNoBnsy1AJdjbw/EG89Cpw3SfbacYqatjLvoiurZueCLhkgpjjSMBnRU+F8L3SteTQFmhigximG0e4v+1lktND36QIk/myTKIhaNiA5VURX/Emi8DqFJTY90emvAsWg4N4mhE+Vwxpqg4e8iQDk5MLFEWqEfIrhI+g2UgJByqMV6sbmJg7EWZY+pW1YR1t+KuA9/T+lXovC9sRvUO11Ie0PRkYbcU4uiBEGnSzo8tCcQDx5H3FVtGUHV6ZDzXMvKAL49fFhYes2uLuOmUIz6rftsXMuVIGP2xkxd7o0EGDcnWSGh/RSVrYH9wn3cDO44xmvmMC0w+BsJMn+RAiKUZlwxfs+9f+T5G2CsEA3T+NKsaOJzCzRoQkFEU3i67UFIfgFNcPFOtqe9woQ9Mae2dqjUnwW3h1FL6Eu7cmqkfZ1ftZ7Ia6jxqaKBhfwv822A6/IDBtGU5Rebm/UJ4CIkg9JK7ah
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(6512007)(8936002)(122000001)(2906002)(33656002)(38100700002)(316002)(6916009)(38070700005)(53546011)(54906003)(26005)(186003)(66476007)(71200400001)(6506007)(508600001)(66556008)(6486002)(4326008)(64756008)(8676002)(76116006)(66946007)(91956017)(66446008)(86362001)(2616005)(83380400001)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Uy/RfTswN0cHnBnqe7U2FhMUD+tfOlwaWbKkT2n/k0nk5YH28XqUcV+VlosH?=
 =?us-ascii?Q?i8qcB9iRKDE9ckm79ho+dbgCx4Udzt+tmJ1Du6EtNpSF2WpVWYa2vcqYu0iF?=
 =?us-ascii?Q?AyD1W1+Zfa6iN/mBcdysrtBQ8gQ8xXJ6xAY1IpjlRY8F7PxkYr1F9HPNvnRT?=
 =?us-ascii?Q?GoLXPiJgpIXLw1zG2wNx/mGupKeBO13V+m2tgRY+UDWB92JVE7G3NzxW7gIC?=
 =?us-ascii?Q?gUrX0OpDUlVao3RfUvIobKewMy1fDaftrK7+V00+YZkyNb3IlX2E5atw7tQt?=
 =?us-ascii?Q?0QxPURHshRGH9F/esVZpJ0CZfvIk7EAJ1SLl66xyQPxz1sW9Brw4ZsptRm1H?=
 =?us-ascii?Q?GCCj4EoAu4vPZ/a3GQ8e5fKFtzfxJCaC0EumySZctbWguntgxVucfv46jwOA?=
 =?us-ascii?Q?az3dHC9V8Mggkdn70x/8vo54bNA5iou0/aTrFwd2HLAVCX9pBowyCqm55Rfy?=
 =?us-ascii?Q?DSgjLdQs9snin2fi81ku7mhgSZo1+OAqES23VR1jnA4jSoGl+HTD0h9ITDox?=
 =?us-ascii?Q?ErdGtM33e0fw9drO2UrbkL82wMECpRJk//w2s5NcilTs/JazQFu7MOQW81Ol?=
 =?us-ascii?Q?X05NtyN2s9g33uZ48tSmPE7RghvN6mo7SKkj1JJmn4TEOOWuzII6bRTgzsyw?=
 =?us-ascii?Q?8HrH/SeQwbBtfTLWb3PiNjq9XM/lQseenSS/qwTrSpuNdSB9ONR9ntpNXJP5?=
 =?us-ascii?Q?u8Wy5HvgIgvPKfHzwTjVEnNnTteckO+aGKUYbOSYqrgniGazQPq6O0o04e4S?=
 =?us-ascii?Q?ZfU+jhxo56bzxQiR3nlfWUc7LQRMsuEYE8ENLpNEtV6CBlBIZuLitHRAqsOB?=
 =?us-ascii?Q?cAlVGYOS/1s+vYP2s+mlXRPhAG7cQA/fwKIybyi7k5HtgG97CKHqCeVmh9ut?=
 =?us-ascii?Q?8mrbYuGkqBbbTMXkxC7jnnsWzvkbqmCjspFRyqiN9gwlNgpD8npMrha4+pHD?=
 =?us-ascii?Q?Bp2u4mTpe3giK3kH8U7FT47ivlvsi46EFLPKPcWPPqYbOTtSXTKujW7rIRWJ?=
 =?us-ascii?Q?c6n+R+hQLhnyp4YCn61Z5XSnfTPLo4oiBvCkKUtHGpkvyNPy6rpKFkwpOsZK?=
 =?us-ascii?Q?/91avfr0GqmxOVrmwGo4Q7JDXDxng71WBTAMj25l/l4UfOI2J9SLCJLKTCXo?=
 =?us-ascii?Q?diQbqK61xriV9D9jVzNdgw2Uyl8ap8/HprKz/bG5SuFmQfQLTSaQoUSqW5x8?=
 =?us-ascii?Q?Mcl+2IS9p1UuVsnCdLRnclKVWTXJkFl6rXyBckx/PAzzHUTPl8J8XVFUvNX9?=
 =?us-ascii?Q?eXlS3aD7qstBJzQ7/QuSxFnUHaZJF9XAzEbtYyB3JQk5d9rxFrWdi7egOOYo?=
 =?us-ascii?Q?3ytCm1GRLiHePXTEbBVpSZ/Vn9PgUYGQ/3M60HBOUvVrAkwJa6pYBi/8bWmx?=
 =?us-ascii?Q?av8C4nWVGokInGc1+qquuHeyYNI/CyzDJe+CltGNnQHBcVQ2dRXUQWbtMAbE?=
 =?us-ascii?Q?zLA/UAWuJglQR3aUvDYPBIu0f+iFEqz5HXBt3GJaNJghqovFhFvvBPh5hqJo?=
 =?us-ascii?Q?BicjR9gigEHF2CXUBeWiKwRAze1vfw4ZWDwMGPBTs5NLuCrTX9Rkx+nwIPB3?=
 =?us-ascii?Q?P3jA/bPsmhqpOFvTpx56g1wU+ZDdMR+77J6T+ClveJlF0hLukhCn/c4/Uxdq?=
 =?us-ascii?Q?Vys5Yg2TnlWNEqu4undekM1KEqRYdHG4k6JOygewsbt7lRCbiI4Q+dq9S1Ol?=
 =?us-ascii?Q?5vAhVtOQClwtb9NL7TdGg+Psp0uBAKdk+mY49kUl9JLwuFk2DVtRH6iJszdV?=
 =?us-ascii?Q?7JOsdnQuEqHxMbHmwia4kD1UkZ54hhw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E0C83EC718C1634DA6772D5E52D4D6E1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09814769-4791-4be2-2b48-08da10c470bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 14:08:31.6268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PzNmyNZmhiDXBxRRq/vMQT5DiwLAKyShKCGW3XUWf676tEmUIfIT46jeRAs1AwBja18dLNrLzfl62TzRCwND7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1807
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10299 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203280082
X-Proofpoint-ORIG-GUID: J3hX9a-IajIVFX0NCL6aZmn4tItuGcdr
X-Proofpoint-GUID: J3hX9a-IajIVFX0NCL6aZmn4tItuGcdr
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 28, 2022, at 12:32 AM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Sat, 26 Mar 2022, Chuck Lever III wrote:
>> Hi Neil-
>>=20
>>> On Mar 24, 2022, at 8:24 PM, NeilBrown <neilb@suse.de> wrote:
>>>=20
>>>=20
>>> [[ This implements an idea I had while discussing the issues around
>>>  NFSv4 client identity.  It isn't a solution, but instead aims to make
>>>  the problem more immediately visible so that sites can "fix" their
>>>  configuration before they get strange errors.
>>>  I'm not convinced it is a good idea, but it seems worthy of a little
>>>  discussion at least.
>>>  There is a follow up patch to nfs-utils which expands this more
>>>  towards a b-grade solution, but again if very open for discussion.
>>> ]]
>>>=20
>>> The default cl_owner_id is based on host name which may be common
>>> amongst different network namespaces.  If two clients in different
>>> network namespaces with the same cl_owner_id attempt to mount from the
>>> same server, problem will occur as each client can "steal" the lease
>>> from the other.
>>=20
>> The immediate issue, IIUC, is that this helps only when the potentially
>> conflicting containers are located on the same physical host. I would
>> expect there are similar, but less probable, collision risks across
>> a population of clients.
>=20
> I see that as a separate issue - certainly similar but probably
> requiring a separate solution.  I had hope to propose a (partial)
> solution to that the same time, but it proved challenging.
>=20
> I would like to automatically set nfs.nfs4_unique_id to something based
> on /etc/machine_id if it isn't otherwise set.
> - we could auto-generate /etc/modprobe.d/00-nfs-identity.conf
>  but I suspect that would over-ride anything on the kernel command
>  line.
> - we could run a tool at boot and when udev notices that the module is
>  loaded, and set the parameter if it isn't already set, but that might
>  happen after the first mount
> - we could get mount.nfs to check-and-set, but that might run in a mount
>  namespace which sees a different /etc/machine-id
> - we could change the kernel to support another module parameter.
>  nfs.nfs4_unique_id_default, and set that via /etc/modprobe.d
>  Then the kernel uses it only if nfs4_unique_id is not set.

- Repurpose nfs.nfs4_unique_id to be the system's default uniquifier,
  and use the sysfs API for replacing it as needed.

Some logic would be needed when building initramfs to sort out whether
to use the module parameter or the boot parameter. </handwave>


> I think this idea would be sufficiently safe if we could make it work.
> I can't see how to make it work without a kernel change - and I don't
> really like the kernel change I suggested.=20

I like the idea of having a fairly reliable default uniquifier for
init_ns and then educating the container folks about how to set up
a uniquifier properly when materializing a container instance.


>> I guess I was also under the impression that NFS mount(2) can return
>> EADDRINUSE already, but I might be wrong about that.
>=20
> Maybe it could return EADDRINUSE if all privileged ports were in use ...
> I'd need to check that.
>=20
>>=20
>> In regard to the general issues around client ID, my approach has been
>> to increase the visibility of CLID_INUSE errors. At least on the
>> server, there are trace points that fire when this happens. Perhaps
>> the server and client could be more verbose about this situation.
>=20
> I found the RFC a bit unclear here, but my understanding is that
> CLID_INUSE will only get generated if krb5 authentication is used for
> EXCHANGE_ID, and the credentials for the clients are different.
> This is certainly a case worth handling well, but I doubt it would
> affect a high proportion of NFS installations.
>=20
> Or have I misunderstood?

That sounds right to me. I don't believe the Linux NFS server ever
returns CLID_INUSE if the principal/flavor is AUTH_SYS.

Note also that the protocol allows a CLID_INUSE response to return
the IP address of the conflicting client, but NFSD doesn't do that,
I guess as a security measure.


>> Our server might also track the last few boot verifiers for a client
>> ID, and if it sees them repeating, issue a warning? That becomes
>> onerous if there are more than a handful of clients with the same
>> co_ownerid, however.
>=20
> That's an interesting idea.  There would be no guarantees, but I would
> probably report some errors, which would be enough to flag to the
> problem to the sysadmin.
>=20
> Thanks,
> NeilBrown

--
Chuck Lever



