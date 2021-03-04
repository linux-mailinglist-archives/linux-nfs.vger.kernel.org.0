Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E30332DBE9
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 22:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240103AbhCDVkV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Mar 2021 16:40:21 -0500
Received: from esa12.utexas.iphmx.com ([216.71.154.221]:54728 "EHLO
        esa12.utexas.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240087AbhCDVj6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Mar 2021 16:39:58 -0500
X-Greylist: delayed 393 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Mar 2021 16:39:58 EST
IronPort-SDR: CfZk7+eaV7T9p2TAnGWMbbSgCmuqgMTP4PAtzZ1hpSoAXsyUQvyR3zDJFlmDllIrHGiW6o3G6+
 xlzo859CdfXC/cLSBjohKjlJ9pevf1wYjLxYCXgqR+P4/1NSpKBc1SxeNRS35T7749G6EC7Lqp
 UtEaL08kVy4maZ7KVm9s67R5r6UrksHXKBioXWYHd3QCz9ZiTNBd6WvVYdxl3h2V1fOh7WSaAj
 xvzXwEb8JCYUyVcMIOCGe5OdB+b1ClaQgPJUoiHof74+7QMsm845eHENR63sl4FiYacQJjPtij
 mQs=
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 265941502
X-IPAS-Result: =?us-ascii?q?A2EMBwChUEFgh2s3L2hiHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+BU1GCPgoBhDaDSQEBhTmIKAglA5khglMDGDwCCQEBAQEBAQEBAQcCMgIEA?=
 =?us-ascii?q?QEDhEoCNYFHJjgTAgMBAQEDAgMBAQEBBgEBAQEBAQUEAgIQAQEBAYYBOQ2DV?=
 =?us-ascii?q?U07AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBQKBCD4BA?=
 =?us-ascii?q?QEDEhEVCAEBOA8LGAICJgICMiUGDQgBARcHgk6CVgMvAaEZAYEoPgIjAUABA?=
 =?us-ascii?q?QuBCIoIgTKDBAEBBoJMglgYQQkNgTsJCQGBBCqCdopNQoFJQoERJwwDgjYuP?=
 =?us-ascii?q?oQmgy6CX4IXcVEBP0wlBREpGSYoCz6LQIRvCosTgR9YmmeBFIMGkEaFN4YXB?=
 =?us-ascii?q?QcDH4M3kB4sj1W2cgIEAgQFAg4BAQaBa4F7MxoIHRM7gmlQFwINjh8Zg1aKe?=
 =?us-ascii?q?FQ4AgYKAQEDCXyKCAEwXgEB?=
IronPort-PHdr: =?us-ascii?q?9a23=3APsCrHhZHNSnPeVgaSk/aIUv/LSx94ef9IxIV55?=
 =?us-ascii?q?w7irlHbqWk+dH4MVfC4el21QSVD5vU5ugCiOfMta3kH2sa7sXJvHMDdclKUB?=
 =?us-ascii?q?kIwYUTkhc7CcGIQUv8MLbxbiM8EcgDMT0t/3yyPUVPXsqrYVrUry6s4jMIXB?=
 =?us-ascii?q?byLwx4IqLyAIGBx8iy3vq5rpvUZQgAjTGhYLR0eROxqwi01IEWjIJuJ7x3xA?=
 =?us-ascii?q?HOpy5NcvhWg350KEKahFDx6trj8Q=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.81,223,1610431200"; 
   d="scan'208";a="265941502"
X-Utexas-Seen-Outbound: true
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by esa12.utexas.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 15:31:39 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/Qb7z4JvAu+BH135q8KoVLS5BreNqLAhJ+ugDc/atsevWReav5xTFLPKHLgONgPgppezbjn0W+QG/0MdVG66sJeMQGYb9ZGCMzzhg8qVaX7+2BOUUZ6ZZB1it0IdNXfQJDR/Hv5dMIQrxc24EG5K7FrXiNUGXhla0YDUAlhT+R36Mv574wtdEcoolYkGW2w99DYQFdEmRk7XDecetrjv1in1txljp3jVJ2/UP2mKlmIuyullbsCTosvtMNm2E9win+2vkvMu/SMi/O2dg7Nnp0MBqe2oXfpMoX9PPF7lSKdgTEp90OPQBVUlln3/wj1rp95fsQLjQVSCuNOt3oLrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrCS5dP2GljeOg42/XrcIrIawqvR6OdzN8MDg8shn8s=;
 b=mO+yr+syHTSOl3Acdkmd2whWZxgLKakYqUN/BpJbmgAT84k1fPIqKV2BiaIi59XN82Pw1fsbPsbAY7uqW3Gn5bWLty+NMcDom6nap09DhdnthO1j2TCuU8hh2YzAvaBe75jT0sW5ZAQEhQQtERMOKBmJPGUHJYmkmZxGz1F2TXO4zH+thaEkE3tkjQGb9zR5qf75tgoSHe4Tq4hLhkkgODQqRwmMnnfPNCDoaF1uYAlAwGwZ63sY4jNmtZBL9ahNutsBOOmTRX2sz0Z1e4lwfhrDWyT/si+dpX5xk0w02hG8Fo+I4D2pqm33dbnxPnZbTcxAyoGZiha3R64GHe5GZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=math.utexas.edu; dmarc=pass action=none
 header.from=math.utexas.edu; dkim=pass header.d=math.utexas.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector1-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrCS5dP2GljeOg42/XrcIrIawqvR6OdzN8MDg8shn8s=;
 b=EtxeluMt1F+n5BY9sLKCiyipIVbFrtK/T7PAFM2fN8Xjykc0MCGyfjSQ9DzLw5ctEWDhGzMzZ9Oefxxmnrx1a3qgblgJZoGDs3Kd1FMPSyt71gAhY24lgbzGeqyHeS2D615eIZrjrEtdiyZIS6gJ16WpxOGVIh65HmBHLz5LpO8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=math.utexas.edu;
Received: from BYAPR06MB3848.namprd06.prod.outlook.com (2603:10b6:a02:8c::15)
 by BYAPR06MB5303.namprd06.prod.outlook.com (2603:10b6:a03:cf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Thu, 4 Mar
 2021 21:31:37 +0000
Received: from BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::a1fb:e18c:8af5:666e]) by BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::a1fb:e18c:8af5:666e%4]) with mapi id 15.20.3890.030; Thu, 4 Mar 2021
 21:31:37 +0000
Subject: Re: [PATCH 0/7 V4] The NFSv4 only mounting daemon.
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20210219200815.792667-1-steved@redhat.com>
 <20210224203053.GF11591@fieldses.org>
 <1553fb2d-9b8e-f8eb-8c72-edcd14a2ad08@RedHat.com>
 <20210303152342.GA1282@fieldses.org>
 <376b6b0a-5679-4692-cfdb-b8c7919393a5@RedHat.com>
 <20210303215415.GE3949@fieldses.org>
 <16b186ea-1abc-511d-3c38-1014b470eaa0@RedHat.com>
 <20210304140123.GA17512@fieldses.org>
From:   Patrick Goetz <pgoetz@math.utexas.edu>
Message-ID: <e061f40e-ee62-0b1c-3855-77279c4c77ed@math.utexas.edu>
Date:   Thu, 4 Mar 2021 15:31:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <20210304140123.GA17512@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.198.113.142]
X-ClientProxiedBy: SA9PR13CA0150.namprd13.prod.outlook.com
 (2603:10b6:806:27::35) To BYAPR06MB3848.namprd06.prod.outlook.com
 (2603:10b6:a02:8c::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.4] (67.198.113.142) by SA9PR13CA0150.namprd13.prod.outlook.com (2603:10b6:806:27::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.9 via Frontend Transport; Thu, 4 Mar 2021 21:31:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fa23b07-b7d8-41c3-4f4b-08d8df54e43b
X-MS-TrafficTypeDiagnostic: BYAPR06MB5303:
X-Microsoft-Antispam-PRVS: <BYAPR06MB5303BE13C5522B012C72DFD583979@BYAPR06MB5303.namprd06.prod.outlook.com>
X-Utexas-From-ExO: true
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xbC1fvV/9GzSty1YMdQpYl8Gf2huTUBRdJpVuh8KgkkOY0mYdy8midKs0OJ/oFLQz1k3KpxCvnpAeUHzv9lLPP3NkQ59Cn42i35GOG6w1EZd2BD7iCeZs18wHTapS/fvhJ+up0DhJGG5tKZ2sxZxXtFksvXLlQvN8cMm2EvR+UKsTDckZ9aU7MqThuHcq3/ZxibY3B3Wlnq2qfGLz5+TInnCsTJ0sTM+IjO3kVrnvcCR7Fs55VddG8Eu2s32i5lIykm52TqVq8VWtxNK9nxo0bNoZ4roRkaaGBQn2EBcPFcsWAKTG0Ak3dMKz63WrwupM9q70QD3hg3jspRQME8dUsoD03YDgcAe2AJCbufP34DN9MGlj4Dvi1GyOmXRC2mrAHXC2+3BKnvUrAL0aqmIBU0rK53yEYuIb/YoBoZ95xl+XYmO5Ruk3qLkpG80dasfiXf5CMsoacPMYMZhSX0N83xJJ4RznA0L9swYvnKaDxaDxNcIB04TveRylNnkdMAGXAo+EbYAvHLwGvGyEYnbGcfmXJSg+Uj2+tOIg4yObTUwXmaOMH6iOen+CZMgqckx4sYgl5d9eBRq/qp4qEQX2fOluwvhVtTSiPQ0RQVtVbI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB3848.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(66574015)(16576012)(786003)(31696002)(956004)(52116002)(6916009)(186003)(8936002)(66476007)(83380400001)(53546011)(316002)(2616005)(86362001)(6486002)(31686004)(66946007)(26005)(2906002)(8676002)(478600001)(75432002)(16526019)(66556008)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?by9yakJtb1hWUnlEQmFxYU9jb044UW43UXNNVHBsQWlGamF0REtTM3U4NXl2?=
 =?utf-8?B?YXg2cmR3M0cvS0lpSklQamhScTRYU3NKWWg0ZTFkUVhVbklLdzdnYzdBUG03?=
 =?utf-8?B?Wmc2dGRXa0JsSUgrMUxnbkhGWlZkaiszRXFpc0M5MDNsVWhYNk1DNkNPM0py?=
 =?utf-8?B?VU1LV0tuc0JsUm0zUm4rWTZTeXZJU3hhc3dnOGhSQTVycHBFSVo3K0Y0NUt5?=
 =?utf-8?B?NlhubGMveXJFNW9SejJ5b1NyUUlkeTk5SmRuUmphemZCc3Y5R3R6Z1lBVFN3?=
 =?utf-8?B?TkVoTGFDWDM1dnU0NUFpTC9zNGVsT0g1SmdnTjNPZWQyMTNVZ0FZZGdtR2JV?=
 =?utf-8?B?VEs3eCtpb21ZRENhRnE2dXdXU1hmdkhueDRINmN0OTFTVE9PMTd5N3RtTUFm?=
 =?utf-8?B?Wno2ODBHb2t2Q3dJRzg5WGFoZEJNYTI3TFhwRG1lL0ovQlRnaW8wK3dHcTd5?=
 =?utf-8?B?Q2xWWUNsMWEwOHoxbVN0eDU3Ym42RURKa3l5NmZJdFlzc3QvdHFLVndTcFd3?=
 =?utf-8?B?ZXAraWR4aE5OT3VIODRvNGxTQ3NUMHB5MFFha2sxNHAwdjRwU0JlVWRyVjJQ?=
 =?utf-8?B?cXc5WVNmWkQzUlRYR2Y0K21PdjBOaFExcnBjMFlndldQd1ZKeHJNTTAyY3lx?=
 =?utf-8?B?b081Nmw5NVJiT0VYaEMyMURpdk9UOENVYjJhQXdab0p2bnYxeEJZdE5KVjVK?=
 =?utf-8?B?WkVLY2hxUmovR0VoZkptMW5JVDR6S0EvOWhmMml5ZC9lU01VS1ZOdklJcXY5?=
 =?utf-8?B?aEhFVjJGK0NTOENMOVpvUUFiblFVZ1RSdmw4b1dMWjRwcjJaM0FkajhLbDVr?=
 =?utf-8?B?YUhLd0hUY2FTYm1KalRaREdOMitJU2dJaHg1WmYvbEdjSXZ5VEJudE9sN21E?=
 =?utf-8?B?VllBMkUzZFRCYnE0OC9GR2lmbCs2KzZnZnRnSmtVcjBCRHllaitBVU1acWZ6?=
 =?utf-8?B?NERtYWNWTTNzK3NoSlNsVE90eUdRckR0UXhTc1czQkxyVzZhMXdZalpVdXhB?=
 =?utf-8?B?T0x6QVA0YklxalVMSURBTjZsVng3MStHaU5xTXc1OGxGSlhaWkJBZHoxVjFE?=
 =?utf-8?B?SmRUV0o5aXRHZTVFVktZejBuV1VqbUh0VUFWTlFlVURkWWlXdEI4ZGNrME5p?=
 =?utf-8?B?YktYTS9JM0hURFJkdHNjNEhYT25CNW5tMDVSU3gvWU1XQ0R0RDhiVnVkclhr?=
 =?utf-8?B?aVYrTStnL2FSWnN4ZGNuTmFRWmhiUXNsdDhjdUhML1lKdDMzY2M5OUtTODh5?=
 =?utf-8?B?YVZuSTlmalNmdTJqQ2MwWU1EWjdjeFAxaTRQRUJIaEZocUx3SnJZbEE1b2hH?=
 =?utf-8?B?ZTdOcWhUS1puUERvenZQalViS2VJK3A3SWxZSzdMeEp3VWs1UDVSdnJuVnZy?=
 =?utf-8?B?eXVMMEpGU2RhdXdGdnh1b2ZOQlRqZGpxOFFLK1p1SDAyY2dhWG4wVFczU0Zo?=
 =?utf-8?B?TjlLdHhuWTNMSGRxUnlGb0c5QkUrNHc3ZDdtRDkyMzhDb1gvOFZhWG13VHlC?=
 =?utf-8?B?dkdWVHdEUkFyZ1hmZjFOMktncjU5a0sxQXNwOGpqVjZEOXRUL08yS2JDZFE3?=
 =?utf-8?B?TzNlY3BNMENhLzFLdlA0anA2RnJUY3JuZXBMcURrMnpLVklZZzBOaCszUEN1?=
 =?utf-8?B?Umk5R2gyWVJNY0Y0cG9aR0t4d2c0eCsrNGFEamZNaXJOVVNMOXpwQXBSTnJn?=
 =?utf-8?B?enFPZUF0bkRJcUdLQW5xaFBKTkNPK3hDZVZRR1Z2aE5aQkVkek41MjFhT1FT?=
 =?utf-8?Q?7b9psUCOVw0ttzgVyYke1oq7yi265gBTOA3E/vx?=
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa23b07-b7d8-41c3-4f4b-08d8df54e43b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB3848.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 21:31:37.4363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fcSID6jvazO7FtueUDjk0KSvbi5uFcgVkJ2Ifn/pYYpnm1Q62LWDikirWRGf6bHB/tbxU7F2/IIOAyYhAwKbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5303
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 3/4/21 8:01 AM, J. Bruce Fields wrote:
> On Thu, Mar 04, 2021 at 08:42:24AM -0500, Steve Dickson wrote:
>>
>>
>> On 3/3/21 4:54 PM, J. Bruce Fields wrote:
>>> On Wed, Mar 03, 2021 at 04:22:28PM -0500, Steve Dickson wrote:
>>>> Hey!
>>>>
>>>> On 3/3/21 10:23 AM, J. Bruce Fields wrote:
>>>>> On Tue, Mar 02, 2021 at 05:33:23PM -0500, Steve Dickson wrote:
>>>>>>
>>>>>>
>>>>>> On 2/24/21 3:30 PM, J. Bruce Fields wrote:
>>>>>>> On Fri, Feb 19, 2021 at 03:08:08PM -0500, Steve Dickson wrote:
>>>>>>>> nfsv4.exportd is a daemon that will listen for only v4 mount upcalls.
>>>>>>>> The idea is to allow distros to build a v4 only package
>>>>>>>> which will have a much smaller footprint than the
>>>>>>>> entire nfs-utils package.
>>>>>>>>
>>>>>>>> exportd uses no RPC code, which means none of the
>>>>>>>> code or arguments that deal with v3 was ported,
>>>>>>>> this again, makes the footprint much smaller.
>>>>>>>
>>>>>>> How much smaller?
>>>>>> Will a bit smaller... but a number of daemons like nfsd[cld,clddb,cldnts]
>>>>>> need to also come a long.
>>>>>
>>>>> Could we get some numbers?
>>>>>
>>>>> Looks like nfs-utils in F33 is about 1.2M:
>>>>>
>>>>> $ rpm -qi nfs-utils|grep ^Size
>>>>> Size        : 1243512
>>>>>
>>>>> $ strip utils/mountd/mountd
>>>>> $ ls -lh utils/mountd/mountd
>>>>> -rwxrwxr-x. 1 bfields bfields 128K Mar  3 10:12 utils/mountd/mountd
>>>>> $ strip utils/exportd/exportd
>>>>> $ ls -lh utils/exportd/exportd
>>>>> -rwxrwxr-x. 1 bfields bfields 106K Mar  3 10:12 utils/exportd/exportd
>>>>>
>>>>> So replacing mountd by exportd saves us about 20K out of 1.2M.  Is it
>>>>> worth it?
>>>> In smaller foot print I guess I meant no v3 daemons, esp rpcbind.
>>>
>>> The rpcbind rpm is 120K installed, so if the new v4-only rpm has no
>>> dependency on rpcbind then we save 120K.
>> The point with rpcbind is it not going to be started which means
>> it not opening up listening connection that may never be used.
>> This has pissed of people for years! :-)
> 
> OK, but we can do that without replacing mountd and changing the way
> everyone installs nfs-utils and runs the nfs server.
> 
 >
 > --b.
 >

Yes, but then people get involved. The announcement of exportd was the 
tech highlight of my week. It's not about the size, it's about how 
distros package the tools, documentation, and configuration complexity. 
Taking these one at a time:

If it were up to me, everyone would run Arch linux with NFS systemd 
service files I wrote myself. These service files would pretend that NFS 
v.3 was long forgotten. Unfortunately, I work in a large organization 
with other people and don't get to make those calls. We run Ubuntu and 
RHEL/CentOS, and the systemd service files are configured to launch 
rpcbind as a dependent service. That's a problem because the local 
Information Security Office sees rpcbind as a dangerous cancer and will 
automatically quarantine any machine advertising this service. I've 
worked through the spaghetti ensemble of service units provided by 
Canonical which launch NFS services in order to attempt to undo the 
rpcbind dependency, but it's a pain in the ass. If NFS v.3 isn't an 
option, the distro supplied service files will necessarily be required 
to behave, too.

If the NFS documentation were superlative, this might be less of a 
problem, but the current instantiation of NFS is saddled with decades of 
technical debt, out of date documentation and some new features aren't 
even documented (we've even discussed this on this list). I'm still 
trying to figure out how people know how to set up pNFS, for example. 
NFS v4 is sufficiently different from v3 that the preponderance of old 
information on the Internet is confusing and contradictory. If the 
daemon name is different, that's an immediate and obvious tip off that 
you're looking at out of date information. The people referencing 
exportd are the ones to pay attention to.

Looking at one of my Ubuntu 18.04 server installs, there's configuration 
information in the systemd unit files, there's configuration information 
in /etc/default, and elsewhere. If I set

   RPCMOUNTDOPTS="--manage-gids -N 2 -N 3 -u"

in /etc/default/nfs-kernel-server, does that actually do anything?  Who 
knows? (Actually, if you dig through everything related in 
/lib/systemd/system, it does at least read this file.) Runing tcpdump 
and tracing the packets should not be the solution to every 
configuration question. Any simplification of this is welcome, even if 
the resulting code is 128K *larger*.

Also, I'm guessing NFS would see wider adoption if there were a 
simplified v.4 only packaging option. Just sayin'.

