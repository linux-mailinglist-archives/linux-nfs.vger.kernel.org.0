Return-Path: <linux-nfs+bounces-17819-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B53ECD1B1D9
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 20:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D88343011182
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 19:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4588435F8B2;
	Tue, 13 Jan 2026 19:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="V3W9dHY+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022142.outbound.protection.outlook.com [40.93.195.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF7D30EF88
	for <linux-nfs@vger.kernel.org>; Tue, 13 Jan 2026 19:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768334064; cv=fail; b=IR3mnCNZpJyskIZIXhApi1H453j9gPXHuSLUePFr9uBLmICwdYYPRCYlpvD3i98RGCWilgm8l8gekjUshxihzU4Dfacl4W64h5TaYna7OwlG8bbXQbw3+RN6ZH1LRzXUrVcFSketZUvHZ89rqwNqTXZavX55bWFsgbd5oQCCsIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768334064; c=relaxed/simple;
	bh=2TFsAKmh7abRWizZYBMo2oXKCC+BNNPLFc5T0WubeJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hsOcQybv/82wTONISHXY6cH8ikcvLL3nlmZBZnAqGlg18jJ1fuQtOFbEZ+Yf5JjhECnbsPOL2TadaYeNrSWL9NDf65bIKs4vWrI/1RiSBIazhyPRaue3ZqsKA4wQBqH7X8i1QSy59XVUpw+sQN1ZCCFevl54A9ovl2HGZzBHxgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=V3W9dHY+; arc=fail smtp.client-ip=40.93.195.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=roC4N6goOBhjYwrRRa6gyzLKKrH3In8eleGT50eiBvXniDC1pm3HRO2ZTD/PeDPvFvPpRoNKjAZyCZIN245IbYS2+YnMUT3BUD2rRwFgR2gnn6yKhIcSOPPbsUHx5tr4ugL9lJX6h8VrJ6Ye0ZbbMAe+W8N3IdoEAf5QRUeuBI/z+yKF/MZ/srSCElAQ46SHmkG089zutTMNriJgS17HaWEVJgO+YOAEJiI2hWuLgNhrOyPqFQvJ+MF1AVesZCOjN/3x6LERpR2DapUAUrUWrXcqkGLJItyAq/V8P/LfPct3Bvb9eUDPELXhoY3x2o1lQuq11xBJfhqpUWqvzLMamw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2WRZP8ofl1qm1tfJqyRei7vKK2yKv2U/S1mLZV4HbI=;
 b=nOENKpS1Tq5MY3PZDLKlVrD6r9Mpp4KP8WvBqMG6Fb2VTIfPbzfpz6hj38Z0cSJ0s8+YL0GzG0lIoXg0AgcI7uuG+QETJKwkti/66FfX1dJtOLOhc02JUcSKIbbm0RLXFJfIpRPg2+B7jP0Ku+olR/EbNNpGHBrEkU9KXN4VeuWfQiYIEgrk1ZUDNkMGAORf5xzQZ8aXROJml8q0IjlNLMGOx4ucX2XlUhMKOoKzCnFMESp3ch7WiJNKIHFj5uhqScEoUImB78WuDnnAQDaqP6sdkdvJwlObTM0dfKyk7jnTWlvW154Dfx0TwiM4Jl6JwC0H+Ehdpjc8bJxnZPfGlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2WRZP8ofl1qm1tfJqyRei7vKK2yKv2U/S1mLZV4HbI=;
 b=V3W9dHY+Lqc5Ov9Tk141mBQK3K9c2QwnQ9SNJFpFOflQUbFB+459Zxa4so8UsXTyBSb68rDKSGhjnwk16wmzl6AVXRw8zBCG1I9e/JbW3qgD7itTd4DWVufQFE1UuFh+WnMTOo58gBbe8yxRRj0JWwZluVflk8vhjMdbNUeSn+8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 BLAPR13MB4641.namprd13.prod.outlook.com (2603:10b6:208:330::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Tue, 13 Jan
 2026 19:54:20 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.005; Tue, 13 Jan 2026
 19:54:19 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 0/7] kNFSD Encrypted Filehandles
Date: Tue, 13 Jan 2026 14:54:15 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <86B6E978-C67B-4C78-9E5F-6F171FD62F3E@hammerspace.com>
In-Reply-To: <1c5569bd-fcac-4b55-8e84-3fbc096cdff3@kernel.org>
References: <510E10A4-11BE-412D-93AF-C4CC969954E7@hammerspace.com>
 <cover.1766848778.git.bcodding@hammerspace.com>
 <aac7f668-5fc6-41cd-8545-a273ca7bfadf@app.fastmail.com>
 <2DB9B1FF-B740-48E4-9528-630D10E21613@hammerspace.com>
 <7F8B576A-465B-4DCE-95F9-9F877513DF2A@hammerspace.com>
 <1e92e144-d436-44dd-956f-3125403dfdc8@kernel.org>
 <ECE1341F-BA8A-4DC7-BC9D-BDD6F10F6013@hammerspace.com>
 <dc3d8ff3-f68f-4200-a546-605f0f2e3611@kernel.org>
 <A3F6E0BB-523F-4B99-B583-D6D80E9D7BFB@hammerspace.com>
 <bf09e1e1-d397-405b-aef8-38c44e6c2840@kernel.org>
 <BCFA2167-C883-40C8-A718-10B481533943@hammerspace.com>
 <1c5569bd-fcac-4b55-8e84-3fbc096cdff3@kernel.org>
Content-Type: text/plain
X-ClientProxiedBy: PH8P222CA0030.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::11) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|BLAPR13MB4641:EE_
X-MS-Office365-Filtering-Correlation-Id: bd10d14d-12c3-4ba6-b307-08de52dd8a4e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5kOXid+L4S6hpe13wEQ4SQRD/FIbDUBKqMgwvtwNBUKhDV9T4cPCCD4K5NY8?=
 =?us-ascii?Q?alvJot766a4ruDPZE4/k6Oqm1sulWEWvfaxUSzQ5l00BCxYrmbXkyJk5frsz?=
 =?us-ascii?Q?hCoZnAQXSs7/DqbU+TBSEnKJ7eRKBVuIKve8iUn9SsSuO01VBbr/I6gbaoE7?=
 =?us-ascii?Q?S+q8dV9CPAcELwFnM8SSaHG6Y2Zv36/mtfdGPN0pgBW/zihtnQcLgoTMfqMI?=
 =?us-ascii?Q?/zZH8lT/AeG7QpTwGf+Ve4lE1DiyE6d3MMeoFCETjrrN065XW4YMMxi4vKuq?=
 =?us-ascii?Q?ruUTTN41yxA7L6a1n9DZNHsoEVYIzrSmcXNdhwA7hSbMmWYnKqun6BtY4vgF?=
 =?us-ascii?Q?G7ZlQ37KTaLs5Vq0PBf+o8OFSlfXDcHuyALe5NqrZcUlTZCFK1WZgXHW8XLa?=
 =?us-ascii?Q?DGSYvhH8UnHLbDNrPmrdAHNbWnpkuOv8G4nDjwaEDnXHhrN3jOZcqMHs1CvW?=
 =?us-ascii?Q?9kYvNg0Af0gY9B+M+WbfX1/F7aC5kdDDKK6dicMeG9/mhYdua3s5ply+3jVa?=
 =?us-ascii?Q?GXHryc3GX03SLardNbFEWWg1eJ2GUz1/L+U5+QWtOVzfGr00U55ecLguotTz?=
 =?us-ascii?Q?noVhozyttkrA+GWwiD//w5jKvBpNuA6C2R4NwDD0OwZVb8hSXRwQKaAU2X9c?=
 =?us-ascii?Q?k+YXVdSADm9fRFwdbuDVUqsutlC7uJV2JpdtwpGf6P7CFmkf9vUt/MsOUSa7?=
 =?us-ascii?Q?umXwSZJLHRJ7638bjcnS7NcQbdxYNZZ3Y7t1H1cyrwuVYGXcS0AxKMn6khpW?=
 =?us-ascii?Q?jYEycOvPxjqPAskSs52chO6W8dyREcJzadndWGlRHpj1P2ObWBnhpClZBxMQ?=
 =?us-ascii?Q?a3AWf3I+wBFqiHgHOOsxvH2ioTyaBC4IH11sq4uH+qMMIMXQ8NkJz2SZcr5j?=
 =?us-ascii?Q?YuBfdgz0ywnrC6R+PikLBszpvsu5YzoKOG6A0zeeHOo7GA5eYmIDSOrWjpTa?=
 =?us-ascii?Q?LVMg4G7t7aRz8Fl8MoI1M095ElwgaTprb/YA66WWcEAHv+fnzh3VpijXXn8d?=
 =?us-ascii?Q?EzZ32sxi23EM7u30l9pIY18VJH3mqhwUB7SVJi/ALwGo2F+hFipRFDqjvs9c?=
 =?us-ascii?Q?3TaaLMckLQU2h6By5cJRm8wVuMnPjDNtBrV9qx1dqE6OsDIWTSajLWfVHlP0?=
 =?us-ascii?Q?SFl3d2I8ibLIq3MAfZa1RFmbSIqh8BLLnnPge74eDo9P5l5XBTOYm86VBI6C?=
 =?us-ascii?Q?DABz/MO1UyA4e3LwqXNu0wzQEccKOnmrpTfwzAwhKwJBWfWgCP3pMPmhkb+j?=
 =?us-ascii?Q?jR2rpbJ3ydfguukmMgUSVcKjaauPmrd7fUj3kZPaltS1F4zHvL7QRqqFXGbQ?=
 =?us-ascii?Q?9VLtLQwat9ZcW+B1MUzX0Smhqdv2bYTesQ/ID2D3pRkN+od9JK2tDi4f1ehy?=
 =?us-ascii?Q?hyKo4wD0BLx9NYimM44grTaZZ7DCVQi5aJfM0U6Vz1pjNj7zQBNp7FEWd/PJ?=
 =?us-ascii?Q?cB2SrbuMn2JNhMQGbo0sodeouFzre1Fj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QMs92/mnUnxSbUG5XdaiKonE8901X5cGEBQ/RZld0b8Ny1dNNUFN15fSeGgJ?=
 =?us-ascii?Q?nHFCmHLOTubGH3FKJX0xff35tJwT2t3E+aZzWYjnIoMd/lElDiuLck9tS+Le?=
 =?us-ascii?Q?i9AiK0YeSUewcU3JGQzqaUnKhVmv/s43wSE6157Nv9caSHRgt4jvzL8DI1ON?=
 =?us-ascii?Q?gweecH5lWRJTUKFQdZ0ZKiKlWpIeRZsG3AXiAodVeY5TtzMnBkoFKJmfmT3u?=
 =?us-ascii?Q?tb2peDxuJ18ArERJ7xeGkjP1Rhzq2YJOa6D38kheTEFEKRPplMs02quisiOQ?=
 =?us-ascii?Q?nYtti1oeTTUsaOnxsvSi9bHoaeiNfgnH4+0kbgbnzcm63AF8QNFedUwUQKFb?=
 =?us-ascii?Q?1tMAjNPqb94fuW6BTr21Q/b2SUFL3Tj3syMcUkXvgXJhfVcUDcUXbryeKktb?=
 =?us-ascii?Q?b9PJfLYMUaikzpv0LkW3WD1pgefG52BeoAVMtDqklgObqPmDxTWPaNmCQPM6?=
 =?us-ascii?Q?SbjFzBLHqQEGL0DfnKDG0H9MBqmOpwPrtPfGAm5z9VfP2DvNnoLIET4j+i04?=
 =?us-ascii?Q?WDpVii2WZa1GEcCkyvmlFRCz7wMQOsq2Lu0XRZMc2sph9A7Jjn+XC25ICt1F?=
 =?us-ascii?Q?zCVkeVhmXcK5NIU2UfXsZhKIuA5hEQvbF6CFQaeZkyiC+Lfm69N1X8zj0xjl?=
 =?us-ascii?Q?mX7sb8YOKLLxVOpgHqdvQr7Gxl3NOQ+7CNIeYdteZWAr1G7v78YBCfcnfUgZ?=
 =?us-ascii?Q?uo0PUNOLXM8w6YC4ObdtpRDtffHpCRyc7dkYbgVYJj63+Vu6Nqbw07Tjc5qb?=
 =?us-ascii?Q?MvMH6IXIOk3yInMrZmPo2ikQ/tX309trAMxE3hgPd+FjOVjfI361D+Jhkl6A?=
 =?us-ascii?Q?s5QS+/62teGOADKO/EA8lZd2DB9RE9iYJa8cgCkc18vXvZfIeYcIEZMiOb4d?=
 =?us-ascii?Q?CAqrZ+4rBmja07YVCjUH8CJFJTQv8Fpo2+NhNmvFE2nJ6mCDnWimKkHW9znq?=
 =?us-ascii?Q?Z9pJNDem3lAYOnHRUETjEz7auRBLvKIfkxTYdU4T9kbNPJSnOy6EYeAp2/U5?=
 =?us-ascii?Q?m729AdyKd4uIm/PaV8YTdcCc5n/gWcz5j7ExO2tBep+GmjfKU2CQ2Oxt8cts?=
 =?us-ascii?Q?LmuMlD1CTo35A4zwx8OY5kplXY5snx4Ez9IoD8fB/uTS2M7ps0LiK93VsiWV?=
 =?us-ascii?Q?vKctWEk7Isb3ZPTkaWrNuSxzIxpkSM0IeN1XwbEf4lECVhZ2obqsEzpOgv3O?=
 =?us-ascii?Q?1R8HmSQL6ydh4hi9TJAsQEmBu1URehDchwL9REJyVtEDJ+CjeIs4gE6GHS75?=
 =?us-ascii?Q?Og9DJ7eHqSbolaY98LGOylLge45XsyBdJYZndu8amJfUyyTWHmGYzpOwnFWT?=
 =?us-ascii?Q?R9v9fnPeJ8EkygWP5FizFS8u5USDFQHHIzGCmCMqP6845MlgfnZB0wSjHfZ9?=
 =?us-ascii?Q?bPgIIdAH1LaQ3OjUUmrFQyEHrkqrUZtVM3pgaeWcREPqAVkut3W/E1bMIaf/?=
 =?us-ascii?Q?RS5uBnJH47pAQI2sGPJsoCaQeQaudrQ8H691hVX6v3TURmX+vHGZqCYSRGf+?=
 =?us-ascii?Q?5Qo5EqKqSps2Iw/Z0eWbBb3BasVXWykn4mvVlmhtdcuSCTrN/Hc/dpBhxzdU?=
 =?us-ascii?Q?kKzZm9sPlpfF+GUYeQvpXMLxqsvamT9X2BaJls82AYZXB8U0hdVVxq3wtWEl?=
 =?us-ascii?Q?Ek8Wh4/vAVbFfYmLHlcEoEXpA6nYisYrZNuBuREcDilqpxLoGah0D6dWyUU0?=
 =?us-ascii?Q?gyEsL0Bzka5jW9eHm85Iw3IyRVZrs5XLFKpnjJfVzuAvtH++NocoIgLbgf0/?=
 =?us-ascii?Q?JDJedrg6AzQL3skPckmhZsLvjkmx36o=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd10d14d-12c3-4ba6-b307-08de52dd8a4e
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 19:54:19.6529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L+ciHOGgHMktxbn1os1sU5GQBH6/h2QcBKUPBgyFjCxnnyv8h4kvJEDql1nAccnh82+qJH4ktxknIUBTZnw1HYuI2rrVXp3PlLKV1FFS4ms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR13MB4641

On 13 Jan 2026, at 13:53, Chuck Lever wrote:

> On 1/13/26 12:02 PM, Benjamin Coddington wrote:
>> On 13 Jan 2026, at 11:43, Chuck Lever wrote:
>>
>>> On 1/13/26 11:05 AM, Benjamin Coddington wrote:
>>>> On 13 Jan 2026, at 10:18, Chuck Lever wrote:
>>>>
>>>>> On 1/13/26 10:07 AM, Benjamin Coddington wrote:
>>>>>> On 13 Jan 2026, at 9:08, Chuck Lever wrote:
>>>>>>
>>>>>>> On 1/13/26 6:51 AM, Benjamin Coddington wrote:
>>>>>>>> Hi Chuck - I'm back working on this, hoping you'll advise:
>
>>>> True - we could use siphash or HMAC-SHA256 as he suggested, but both would
>>>> still expose detailed filesystem information to the clients which was
>>>> counter to my design goal of hiding as much of this information as possible.
>>>
>>> We need to understand your threat model before deciding whether
>>> completely obscuring the file handles is more secure than making a
>>> cryptographic hash part of the on-the-wire handle.
>>>
>>> As far as I can tell, your proposal attempts to hide information that is
>>> already available via other means.
>>
>> Not necessarily true.  Filesystems create their own filehandles and so you
>> cannot say that the filehandle will only ever contain information that is
>> also available via other NFS attributes.
>>
>>> What you really want to do is prevent a remote client (maliciously or
>>> accidentally) from fabricating a file handle that can be used to access
>>> areas of the exported file system that have explicitly not been shared. A
>>> hash that cannot be fabricated without the server's secret key would
>>> accomplish that, ISTM.
>>
>> Yes - a MAC will do, as I have already said several times.
>>
>>>> Using a MAC may have the advantage of sometimes resulting in smaller
>>>> filehandles (siphash would add 8 bytes to _every_ filehandle).  But it also
>>>> may not result in smaller filehandles when the unhashed size lands on or
>>>> just under the 16 byte blocks that AES wants.
>>>>
>>>> What would you like to see used here?  I do not think that allocating 32
>>>> bytes for each knfsd thread for this optional feature to be a problem.
>>>
>>> I would like to not add yet another layering violation between SunRPC
>>> and NFSD, especially because there has been no evidence that AES or
>>> anything like it is going to provide any meaningful benefit.
>>
>> I think we can do it without adding yet another layering violation, Jeff's
>> suggestion was on-point.
>>
>> Also, it sounds like you don't agree that hiding filehandle internals from
>> clients is a more complete solution.  I disagree with you but don't need to
>> argue the point, the details are clear.
>
> No, what I'm saying is you haven't described your threat model in enough
> detail to justify the proposed design of encrypting file handles. I'm
> not saying the justification isn't there at all. I'm saying you need to
> bring the rest of us along.
>
> Yes, I found a technical issue with the proposal (abuse of the layering
> boundary between SunRPC and NFSD). But I'm concerned about the bigger
> picture: what's broken? Why does NFSD need this feature? Is file handle
> protection the best or most complete approach? For this initial review,
> that needs to be discussed first, based on the kinds of attacks you
> foresee. Which are ... ?
>
>
>>> Let's stick with the simplest hash/encryption approaches until we
>>> can see that hardware optimization is necessary. That already leaves
>>> out the need to dynamically allocate buffers.
>>
>> I will also assert that AES is pretty simple.  Complexity isn't an issue here.
>> Buffer allocation is also not complex.
>
> The simpler approaches won't demand dynamically allocated buffers, nor
> will they nail another CRYPTO dependency on the NFSD module. I believe
> either encryption or signing can be done without introducing either
> complication.
>
>
>> But you're the maintainer so, ok.  If you don't see value in the current
>> proposal
>
> This is /reductio ad absurdum/ -- I never said I didn't see any value. I
> said the value needs to be explained and demonstrated more clearly.

Sorry, not trying to speak for you - just posited a conditional.

> And, I've read at least two other commenters in this thread (Neil and
> Eric) who have asked clarifying questions about what is the purpose of
> this proposal. So it's not just me.

Sure - I've been doing my best to respond and add context.  I was originally
too vague.  I'm hoping my responses are getting read and are making sense.

> In fact, I agree file handle protection could be valuable, but it
> doesn't feel to me that we have a consensus about why and what it needs
> to do.
>
>> I'll need to rename this feature, because it will not be encryption
>> at all - so how about some bikeshedding?  :)  Hashed filehandles?
>> Authenticated filehandles?  MACFH?
>
> If we decide to use a MAC, "signed file handles" is accurate, concise,
> and follows industry convention.

Cool, sounds good.

>
> But let's do some homework first. What exactly are you trying to protect
> against? Let's hear some specific examples so we are all on the same
> page.

OK - I feel like I've done a lot of explaining already in my responses, but
here goes I'll try again here and I think maybe I'll get better at this with
repetition.

> I'm asking because the folks on this mailing list you are presenting
> this to for review were not present for the in-person discussion, or
> more pertinently, might not know or care to know how NFS file handles
> are utilized.

Roger.  Do you want me doing that here or in a v2 (no linux-crypto here)..
It seems like you have a pretty good idea of what I'm trying to accomplish,
so maybe you can just give me a hint so I can start all this over in the
right direction.  Discussion might be better on a fresh posting, I have
fixed the nits in the RFC..

> (How did linux-crypto get stripped off this thread?)

It wasn't ever on this thread, you added it to 6/7, but this is 0/7.  I'll
include them on a new version as you asked.

> I'm also asking because the feature will need coherent administrative
> UIs and documentation. Having a detailed threat model (also listing
> threats that are not designed to be protected against) will help
> immensely.

Yep - I promised this on a v2, and just want to not waste my time.

> So here are some questions that might be pertinent to me doing a
> diligent review:

So, I am tempted to reply here - I think you know most of the answers, I will
reply more completely in v2 unless you really want me to get into it in this
thread.  I'll try to be brief here because - yes, we're going to need to go
over all this all over again in the next version (with linux crypto):

> Is the issue an artifact of the design of the NFS protocol?

No, it's in the nature of a filehandle.

As you know, a client that has a filehandle can access a file without
needing to walk the directory tree to the file's location.  That walk might
have permissions set on parent directories above the file that restrict the
walk to the file from that user.  We'd normally expect those permissions to
keep those files from being accessed or looked up, but when filehandles are
not completely opaque - its trivial to guess them and bypass the security
that might exist on a directory walk to the file.

> Is it a problem specific to the Linux NFS server implementation?

I suppose other server implementations can have the same problem, but I
cannot answer this question definitively.

> Is it a problem specific to certain file system types?

Yes - the ones that have very predictable file handles.

> Is it a problem specific to certain export options? (I think I heard a
> yes in there somewhere)

Yes - specifically its a problem when a server exports the same filesystem
to different clients using root_squash for some, and then those clients are
arranged in a way that one of the clients acts as a broker to "hand out"
filehandles to authorized non-root-squash clients.  This is the flexfiles
scenario that I am interested in.  I am happy to go into much more detail
about this.

> Why precisely do you believe obscuring file handle information is more
> beneficial than simply signing it?

 - the client doesn't need the Message (M in MAC), so it doesn't need to
   verify the message or decode it - which is the normal use case for a MAC.
   Adding 8 bytes to every filehandle may be an unnecessary overhead on a
   wire protocol.  Balance this with the fact that using AES-CBC will need
   to pad out a filehandle to 16 byte boundary.  With all the different fsid
   and filed lengths, depending on the filesystem, I think this argument is
   a wash really.

 - If using a MAC, the more filehandles a client has, the easier it may be
   to guess the secret.  Of course, that can still be practically
   impossible, but the scale of work to break a completely encrypted
   filehandle is far higher since the client does not have the original data
   used to create the hash.

 - A non-obscured filehandle can still reveal information about the
   filesystem that the NFS server does not intend.  NFS doesn't control the
   data in the filehandle.  This information is probably better kept
   unrevealed to a client, as the information itself is outside the control
   of kNFSD.

> Why do you want to protect file handles, in specific, without using in-
> transit transport encryption like krb5p or TLS, or without protecting
> other XDR data elements?

Because I can have different non-root users on the same client that share a
krb5p or TLS wire encryption transport, but not want those users to use
open-by-filehandle to attack an export and gain access to files below a
directory they are not actually allowed to walk into.

> How much work do you think an attacker might be willing to do to
> crack this protection? This goes to selection of algorithm and key
> size, and decisions about whether one key protects all of a server's
> exports, or each export gets its own key.

It depends on how valuable the data might be to the attacker.  I hope we're
making products that banks and governments and nations can depend on.

> What are your performance goals and how do you plan to measure them?

I need the feature to not significantly slow down operations at
datacenter latencies.  I'm expecting a small performance hit, but I
really don't want to wait for things like memory reclaim.

I suppose we can brute-force both approaches to compare them, but I think
for a wire protocol the time to hash up to 128 bytes on a local cpu to be
statistically insignificant.

Chuck - I hope you can simply tell me to use MAC or AES on v2, and we can
shoot it full of holes on the next posting.  Can we do that on fresh version
-- can you pick a direction you'd like to go?

Ben

