Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09CF8300412
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jan 2021 14:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbhAVNX1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jan 2021 08:23:27 -0500
Received: from esa12.utexas.iphmx.com ([216.71.154.221]:5287 "EHLO
        esa12.utexas.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbhAVNWq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Jan 2021 08:22:46 -0500
IronPort-SDR: +OK1v7d4hVV5YNacVfBTM915CAEhmSPI/LVj3+jng6kZFGIq1ylN/+/Pdn+V8z21k0AMC+pDIC
 LCRYHANdRm368jrFbGSYfQhElVO7Xzyo0Zds0TP6YTDgVTkQOsPSgh63xE8gOaRXxzWklqg/Oj
 SpvAihzj8YHeFxmqmYyAVjm/I8tgTQJBCb0dbe/TAEmJFDMEJAczl29eUbQ5yIp4jzzyvAQWaB
 1etl5XnII+seQz9FL9/L4aDDqYPGxJIcn1GFmxxrmOsG3Gp823Perxlucvtcc0jc133tekiRVL
 GJg=
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 260510608
X-IPAS-Result: =?us-ascii?q?A2HwCQBa0Apgh6o3L2hiHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+BUykogjYKhDaDSQEBhTmIKC0DmReCUwMYPAIJAQEBAQEBAQEBBwItAgQBA?=
 =?us-ascii?q?QKESAI1gUUmOBMCAwEBAQMCAwEBAQEGAQEBAQEBBQQCAhABAQEBhgE5AQuDV?=
 =?us-ascii?q?U06AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBQKBDD4BA?=
 =?us-ascii?q?QEDEhEVCAEBNwEPCxgCAiYCAjIlBg0GAgEBHoMEglYDLgGlLwGBKD4CIwFAA?=
 =?us-ascii?q?QELgQiKCIEygwUBAQaCTIJUGEEJDYE6CQkBgQQqgnaGUYN0QYFBP4E4D4JjP?=
 =?us-ascii?q?oQmAoMvgmCCBD5EGzEFHDACDUQSRhslHwYVLZI4AYk9V5tbgwGbXwUHAx+DK?=
 =?us-ascii?q?49rK48zlB6cVy4LhEMCBAIEBQIOAQEGgW2BezMaCB0TO4JpUBcCDYEgjQEMD?=
 =?us-ascii?q?gmBAgEJgkKKd1U3AgYKAQEDCXyIRYE0AYEQAQE?=
IronPort-PHdr: =?us-ascii?q?9a23=3AJlAYOxc+/g8YlupPuW0JuM06lGMj4e+mNxMJ6p?=
 =?us-ascii?q?chl7NFe7ii+JKnJkHE+PFxlwaTB9fc8ftPj+eQuKflCiQM4peE5XYFdpEEFx?=
 =?us-ascii?q?oIkt4fkAFoBsmZQVb6I/jnY21ffoxCWVZp8mv9PR1TH8DzNFrIq3a24HgZHR?=
 =?us-ascii?q?CsfQZwL/7+T4jVicn/3uuu+prVNgNPgjf1Yb57IBis6wvLscxDhIJ+KuAs1h?=
 =?us-ascii?q?bZq2AOduhLlm4=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.79,366,1602565200"; 
   d="scan'208";a="260510611"
X-Utexas-Seen-Outbound: true
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by esa12.utexas.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 07:20:53 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0daeUa9bh7+wmztYL+6ET8Nd9hGRKCJEBE6b05SzGYdFdt5IVQt3X3Exs+PzXz3FWOMF54IXtoNZ3V7qLKjU4/jPZRfMo2ivejoJqs+aE5j0C0raHi9VC9RKHeu2+JmpSBKlji25tY3CCxer28F9wF3PY3KAVLEvBVuANy07QMTFtMLxIIxTlnDvhwvDWquQdUD02Ra6dhTyz1s0y3n35PTH/YtkhMvMXjNwcUp2m5KL9/TnBtcCEqylIJCzbxq0aXGqz2nf+ahKmyt7pi6j6BfQWTEhxpGo9DRBzXUKPtYlx2OjFxmALv6E0ChaLrM6KKBiiEB7QoOPdrt3DJ5AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4qGadNO871Z1i+Kgc7FO6ei5EcITFScIZ2Qnpsw/oY=;
 b=XsCRhvS2uEzHEGtfVX7lUIDw3Vy6017GZg49LTEqrHyC/lhzz9S9H1EmEyxDJvy0N+deRgppuNFdm7b76jGkUYZA0rrH4anexx+3FGnp/81mfmZlOtm637MGik2MSDsc9voAbcVN0Mz9FJjlcZeo430XTspvRKMqZ5iFIclGnUXstzfEXsdu9/hjJAfrqnjBcbKabKIJpcglbhpdDwcHFhPA0b2JrDl/IMT0R7ijHsCmZyGmnSh7sU1zBskeF4tWl0sdjsrAr96mvC/ubVcVi4Rx2Pz/o0uU8rs/bTWMf2dK1wwsULgERMYiZW8CxpaA64AYfkiEOjIrELR8LiTxBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=math.utexas.edu; dmarc=pass action=none
 header.from=math.utexas.edu; dkim=pass header.d=math.utexas.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector1-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4qGadNO871Z1i+Kgc7FO6ei5EcITFScIZ2Qnpsw/oY=;
 b=iPHHYfsEHhnXtPUL0Q7vdo2MlHQtyrKZJG6MSjdIi8tBaeTtz26qkfbNy5hTvvcyOtjqSGhDLBOc98AF4dMVcZZ1GQiK7+MtczNFWJSqMe5GLiVhIWMKiSaAZEkCIcqw3qeT4bYkUNGTVZ7elr1193XNUV7pZaF/fh6p/h9+bSU=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=math.utexas.edu;
Received: from BYAPR06MB3848.namprd06.prod.outlook.com (2603:10b6:a02:8c::15)
 by BYAPR06MB5384.namprd06.prod.outlook.com (2603:10b6:a03:dc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Fri, 22 Jan
 2021 13:20:50 +0000
Received: from BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::a1fb:e18c:8af5:666e]) by BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::a1fb:e18c:8af5:666e%4]) with mapi id 15.20.3784.012; Fri, 22 Jan 2021
 13:20:50 +0000
Subject: Re: nfsd vurlerability submit
To:     "bfields@fieldses.org" <bfields@fieldses.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "wangzhibei1999@gmail.com" <wangzhibei1999@gmail.com>,
        "security@kernel.org" <security@kernel.org>, "w@1wt.eu" <w@1wt.eu>,
        "greg@kroah.com" <greg@kroah.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
References: <20210111193655.GC2600@fieldses.org>
 <CAHxDmpR1zG25ADfK2jat4VKGbAOCg6YM_0WA+a_jQE82hbnMjA@mail.gmail.com>
 <CAHxDmpRfmVukMR_yF4coioiuzrsp72zBraHWZ8gaMydUuLwKFg@mail.gmail.com>
 <20210112153208.GF9248@fieldses.org>
 <8296b696a7fa5591ad3fbb05bfcf6bdf6175cc38.camel@hammerspace.com>
 <42fcbc42-f1b3-5d99-c507-e1b579f5a37a@math.utexas.edu>
 <20210112180326.GI9248@fieldses.org>
 <eb09db3a-9b43-cf03-5db4-3af33cb160e6@math.utexas.edu>
 <20210121220402.GF20964@fieldses.org>
 <a6429a2c-ce90-caec-0704-6626cd564300@math.utexas.edu>
 <20210122013019.GA30323@fieldses.org>
From:   Patrick Goetz <pgoetz@math.utexas.edu>
Message-ID: <db4ccb47-370c-7f05-ae15-41b7cd90c2d7@math.utexas.edu>
Date:   Fri, 22 Jan 2021 07:20:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20210122013019.GA30323@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.198.113.142]
X-ClientProxiedBy: SN4PR0501CA0091.namprd05.prod.outlook.com
 (2603:10b6:803:22::29) To BYAPR06MB3848.namprd06.prod.outlook.com
 (2603:10b6:a02:8c::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.7] (67.198.113.142) by SN4PR0501CA0091.namprd05.prod.outlook.com (2603:10b6:803:22::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.6 via Frontend Transport; Fri, 22 Jan 2021 13:20:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fcd0987e-d0b1-4c6f-69fc-08d8bed8894f
X-MS-TrafficTypeDiagnostic: BYAPR06MB5384:
X-Microsoft-Antispam-PRVS: <BYAPR06MB53845E57F86EA478F41B6D9383A09@BYAPR06MB5384.namprd06.prod.outlook.com>
X-Utexas-From-ExO: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TaeyS5ebB3R+54rAxBjYqhL2o69FAL1INETw8RchgVTs2ddsVGmPDEcchs4QbB7OLJpmQCuTYgQg/MoODF33bkw7yOXGQBlBhBFqFtAru0rbjpKhJsosB1Zut3vKC9u2uTvzQ6s4zTrcX26iEZT9N1UvpbPvPVLwsJN3N+00PBDRb9Dz7P6KmBUguGZ2t/0ee/6EufWWTT/H71tnLbF64QWbG1lxHptOM0nQXMgmhnPduK3XzUmkXHdQUD0y3tGDbtFfuN+U2VU9Kt22FOwoeXPDN8dQDXgZEjXHV28j+I0GudUwKTjEVBJJ6NoqRcJfUZwWgmkICpUQXmoXIqmAR7B+r4Bg3hBxFCa2qWq6RzC0UtdNoQlxRuT3VBEBLs9vnZ2MMBysjgj/DHRyZsiaNePU1NO8rCHUZb7XwL5xdEFNqBvGnuDx4NPdgUz5QpDRFgnktSlUXv/O9lCYLTOCTnJclmsK5wZacPVyr5zLFSI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB3848.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(31686004)(3480700007)(75432002)(86362001)(6486002)(2906002)(5660300002)(66946007)(66476007)(83380400001)(66556008)(31696002)(52116002)(316002)(7116003)(4326008)(956004)(6916009)(478600001)(8676002)(2616005)(8936002)(786003)(186003)(26005)(54906003)(16576012)(16526019)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZGtsQVJWMVFpYzArT08wdGF4emlFWjhyL1BscUlTU1k4UUFkTXU3ZURrUU1I?=
 =?utf-8?B?QkkrMnFPQ1M1MTdjVmd3S2tCQnBBQ2U4OVVLNFlHeVcwTnN1TnNTYzd2bnJR?=
 =?utf-8?B?YWRBM2lORkswRC9PWVJRQmR1N25zSU1qeDFBR2RlVk9HTU93YVNJUHg4SHhJ?=
 =?utf-8?B?b0E3TnVLZkRHR2Z0Z2V0c1dhaEZ5QkJrNE9YK1JZbjdMQU5DMHhabG12UkNp?=
 =?utf-8?B?VXR1dkdnUkFtYmtUN0ZyU1kwRC9GaGt5Z0tzWFRWK1dMekl2TGZKSGhmZE0v?=
 =?utf-8?B?YW1lWDUrYjVDWmMxU0NRMkY2UnpUQmk2NjFNdm91QUdKbnJ6ZWZ6bGtBRlJu?=
 =?utf-8?B?bDJBVnVJS0lxNzJpeFMxYmh4SVBKdGhPMTdHSDRyUGkvSHlDL3pHbUdPbEta?=
 =?utf-8?B?ZEpGSW1hRnR3NC9oZ1VNUURZb3AvRlVWcHozSkV4YVVwTlRuZGp5RnAyWTJ0?=
 =?utf-8?B?WGdyQW02enZleEhaenlLSDFtbGtObTZSR3F4QU1hd0V4dWdHQldyOGdCdENO?=
 =?utf-8?B?QTNoN0IxT0hsalJORnVuQnlpdHhpVHBGVlVjWEFOdEdZVDBpNW8wT01uTm15?=
 =?utf-8?B?Nm5HSXQ4STZKczFIZnJhWWkzVnRiOGdGcGxlRmptQWVFRGFVQjhQNzBsSGtN?=
 =?utf-8?B?UVdrM2NKblJRQTVnZnRPSDZKL3hwNGE1ZDU5QkdKUXhSdFpEWjZjMjdLdzRJ?=
 =?utf-8?B?dmY1eE9ObjQvUnZ5dDBaYlYxNEp0R01NR244T2I0NWZrVE9iN1BmWWhHMndE?=
 =?utf-8?B?L0pqYTVtbkVPOHQwcHpQWW1xQVNIWWhJMm9KNUpTY1RCcVJDbjRQK3RGSGN1?=
 =?utf-8?B?bTBBNnEwTC9vTFQ5ZVloYTA2RjBNNHZkVmpSVVNyZXpINUloaGpIWlVVZlhC?=
 =?utf-8?B?ek4vVVh5S3VCbzV6OENoVXVWZk9HUkJQNzlrZHkxcEcwQ3hQZmE5MVU3ajI5?=
 =?utf-8?B?SHdQb1BJYVJUaHNSMUpDeWRLbUZ0dVhGREFkSHJ6am56Qjc2czVVc3NqK2xt?=
 =?utf-8?B?ZTFPY3lydlJpS1lsdHdnSDE5bno4MjRkWmhtUktPc2dCbHVzeENWYTQ5OW9w?=
 =?utf-8?B?NE0zaFZvc21aY2krZFduZzZQZjZNUkE3cFZTMjVRd1ltT3JGa0JUWW0raFl2?=
 =?utf-8?B?dEY2UjBPaFo1Zkg5UlZuKzNOQndCcnpHa0JtbDVYWHdOdjgvN1RLUk5oamh0?=
 =?utf-8?B?eVJvbDYzYnhVcEtUNGQ4M3p5V0U1RXNYcHVHRWx0dEsxSWNhbGsyajNjS21Y?=
 =?utf-8?B?L2NWTmM4cHF6UC93bW5EalZSRU8vVmlkaWU4ZWQ2ZS9RVFNOSWR6ekFNMk83?=
 =?utf-8?B?SG84eXJ0SjhiSUtCOEcxejJ3Qzl3QnQzRjFtQUM0UjJteEFlOGFYK0lNZG9J?=
 =?utf-8?B?R2VxQkc3MFJDQVRxanY3R2E0Ti8xU01mWHhOeEgrWDQ5Q2JoRGcwMVhjSkh6?=
 =?utf-8?Q?4WfFzRgZ?=
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd0987e-d0b1-4c6f-69fc-08d8bed8894f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB3848.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 13:20:50.2459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yk2WVYGwTIljwr2KqbhoBaSo4fctQoDMd9FCLZwZw+wA9hAu5FMq2PFC8dxzjAVlp4L8LnD1hIigJ74dnp80Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5384
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks for engaging; this has been informative.

On 1/21/21 7:30 PM, bfields@fieldses.org wrote:
> On Thu, Jan 21, 2021 at 05:19:32PM -0600, Patrick Goetz wrote:
>> On 1/21/21 4:04 PM, bfields@fieldses.org wrote:
>>> As I said, NFS allows you to look up objects by filehandle (so,
>>> basically by inode number), not just by path
>>
>> Except surely this doesn't buy you much if you don't have root
>> access to the system?  Is this all only an issue when the
>> filesystems are exported with no_root_squash?
>>
>> I feel like I must be missing something, but it seems to me that if
>> I'm not root, I'm not going to be able to access inodes I don't have
>> permissions to access even when directly connected to the exporting
>> server.
> 
> If an attacker has access to the network (so they can send their own
> hand-crafted NFS requests), then filehandle guessing allows them to
> bypass the normal process of looking up a file.  So if you were
> depending on lookup permissions along that path, or on hiding that path
> somehow, you're out of luck.
> 
> But it doesn't let them bypass the permissions on the file itself once
> they get there.  If the permissions on the file don't allow read, the
> server still won't let them read it.
>

That's probably good enough. Security through obscurity isn't a good 
idea, so file/directory level permissions should be atomically correct 
and not rely on directory hierarchies, restricted direct access by 
users, or anything like this.

I didn't not know about the filehandle guessing thing and will keep that 
in mind for the next NFS server I deploy.


>>>> It's not practical to making everything you export its own partition;
>>>> although I suppose one could do this with ZFS datasets.
>>>
>>> I'd be happy to hear about any use cases where that's not practical.
>>
>> Sure. The xray example is taken from one of my research groups which
>> collects thousands of very large electron microscopy images, along
>> with some xray data. I will certainly design this differently in the
>> next iteration (most likely using ZFS), but our current server has a
>> 519T attached storage device which presents itself as a single
>> device: /dev/sdg.  Different groups need access to different classes
>> of data, which I export separately and with are presented on the
>> workstations as /xray, /EM, etc..
>>
>> Yes, I could partition the storage device, but then I run into the
>> usual issues where one partition runs out of space while others are
>> barely utilized. This is one good reason to switch to ZFS datasets.
>> The other is that -- with 450T+ of ever changing data, currently
>> rsync backups are almost impossible.  I'm hoping zfs send/receive is
>> going to save me here.
>>
>>> As Christophe pointed out, xfs/ext4 project ids are another option.
>>
>> I must have missed this one, but it just leaves me more confused.
>> Project ID's are filesystem metadata, yet this affords better
>> boundary enforcement than a bind mount?
> 
> Right.  The project ID is stored in the inode, so it's easy to look up
> from the filehandle.  (Whereas figuring out what paths might lead to
> that inode is a little tricker.)
> 
>> Also, the only use case for Project ID's I was able to find are
>> project quotas, so am not even sure how this would be implemented, and
>> used by NFS.
> 
> Project ID's were implemented for quotas, but they also have the
> characteristics to work well as NFS export boundaries.
> 
> That said, I think Christoph was suggesting this is something we *could*
> support, not something that we now do.  Though looking at it quickly, I
> think it shouldn't take much code at all.  I'll put it on my list....
> 
> Other options for doing this kind of thing might be btrfs subvolumes or
> lvm thin provisioning.  I haven't personally used either, but they
> should both work now.
> 
> --b.
> 
