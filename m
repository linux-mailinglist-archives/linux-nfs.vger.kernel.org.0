Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6664F437C8D
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Oct 2021 20:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbhJVSZf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Oct 2021 14:25:35 -0400
Received: from mail-dm3nam07on2045.outbound.protection.outlook.com ([40.107.95.45]:9530
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233841AbhJVSZf (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 22 Oct 2021 14:25:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEeBalmY+RXXu8d09cf/ei75qfZFQ1N3N40VEf9PaoSa7MO6hJwq9Gnua174Ms2v+OZQxckWS583vVsCrtybMTwyRDN0a7/J2nTtPYb6q+9rNfEuKEak7laASFDWnP0lJ3XhbpcRhVPLOccyoSZrE4a/X3smIvS97UPlCL/YdKK9zAmyKoOcGTUHoUdz5E8EWfcH2CS/We+mRXofeIy307gSC0b56W9eUoDI9Msy14Bg2InvuH0TQXAD16/onprJQmLCaa6T1otDTOwGqUU7CxFUAqijbq/ZgK1KTR7JOMoS1Y08FrlEkD0j0eK6CIY9+CMSIVLvCu8JMPtS3XoZRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TAq7glfG7YKabJ6faaOVx5X6BWXibpx/5Y6SVr8kTA=;
 b=RcETuzlKEs3xUbvJsTYm05XijTYyfsgiRdWaZILn5WIThITk5LinpXAHODBEBzqTo2bpZCm9zSCJnGOQduvOsTnNkNC6p9jiCNKscyv2XY9Tb9IGh01CY2Ac7EOGWZI7MFP/YyyeT9q64GubO9+qzyCZaVbXpbebq8hei+wUenScTqcULVcyGaCFkNOAFcAaUM0HD8UD89CM8PK+pYmGnYRBIL6fHRbrZDpZMqpudHsmQDaWchEMsAxm0uA9VbhLxthjxoL2/UsSwk1/Z7uCkmUpch5G2wjNiX3f+ebza8QUG+UaAn3dnh5SoLDK4e+UgsZ7uOMAwtIv36XbRQQpdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cooper.edu; dmarc=pass action=none header.from=cooper.edu;
 dkim=pass header.d=cooper.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cooperunion.onmicrosoft.com; s=selector2-cooperunion-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TAq7glfG7YKabJ6faaOVx5X6BWXibpx/5Y6SVr8kTA=;
 b=ewcRSAGXpbEcR+0RnhbzFjpuN4WU5v0HJMiAjqJWUNb29fj2ua8rSjFbN0iOXC1JYwhxWddgsa6DlKSbD46GgAL8iIoH4MkIJc/8NzRqj8qsyuS7pZxeywiL7HnsPkQ2NAYljxWHvzTOqJLVM9w2HnyNf2kmmteVD4GevcfYhb8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cooper.edu;
Received: from BY3PR18MB4610.namprd18.prod.outlook.com (2603:10b6:a03:3c1::12)
 by BY3PR18MB4658.namprd18.prod.outlook.com (2603:10b6:a03:3c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 22 Oct
 2021 18:23:15 +0000
Received: from BY3PR18MB4610.namprd18.prod.outlook.com
 ([fe80::d0b4:256:6b3c:71a]) by BY3PR18MB4610.namprd18.prod.outlook.com
 ([fe80::d0b4:256:6b3c:71a%9]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 18:23:15 +0000
Message-ID: <3ecabd29c9de3f58a691a963f1c481264cfb0105.camel@cooper.edu>
Subject: Re: NFS v4 + kerberos: 4 minute window of slowness
From:   Dan Mezhiborsky <daniel.mezhiborsky@cooper.edu>
To:     Robert Milkowski <rmilkowski@gmail.com>, linux-nfs@vger.kernel.org,
        trond.myklebust@hammerspace.com,
        'Chuck Lever' <chuck.lever@oracle.com>,
        "'Schumaker, Anna'" <Anna.Schumaker@netapp.com>,
        trondmy@hammerspace.com
Date:   Fri, 22 Oct 2021 14:22:04 -0400
In-Reply-To: <07d501d62e94$26c72070$74556150$@gmail.com>
References: <20ce01d62303$70571e80$51055b80$@gmail.com>
         <109301d62a2f$b88f0ae0$29ad20a0$@gmail.com>
         <07d501d62e94$26c72070$74556150$@gmail.com>
Organization: The Cooper Union
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0143.namprd02.prod.outlook.com
 (2603:10b6:208:35::48) To BY3PR18MB4610.namprd18.prod.outlook.com
 (2603:10b6:a03:3c1::12)
MIME-Version: 1.0
Received: from [172.22.116.195] (199.98.27.215) by BL0PR02CA0143.namprd02.prod.outlook.com (2603:10b6:208:35::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Fri, 22 Oct 2021 18:23:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c5f5139-0212-43d8-c5b3-08d99589032d
X-MS-TrafficTypeDiagnostic: BY3PR18MB4658:
X-Microsoft-Antispam-PRVS: <BY3PR18MB46581CF530809E5C0D782EA6EC809@BY3PR18MB4658.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BszMtS5jFtlu3AZC/IgluZAMi4lCZWREbgIhYFxT6HZD5VZbxMxGDkktAG5CyfvgBLtvrg7y0lne52rIpCz5s8zDb7SMwVuW715OyYywNqLBNoa2+95ry0P8QlWc5LnWzdc2YwS4cXen68B1SnvRQ0K8KnXsuf0Z3ZQZKet5i//v53vuc2dmwZw4a1xUrGK9HmOk5Eo99E9pAKHhHvglCKUyveEARgvYvk/1UG/vNrJrSnxrWEzi7yaJbU3XIrBFndXRNGGsSz8IcN4TO1ijJMIR8qhzScGlcrS9lZyC47/nBD8bDY86l/jlCfZkQvUaeRj0/QFiaeg9QBnJlYrumBT9PRWbHvcGJoeRH2blYCG1sUFUFZcNTu0XHFu2lPbNLPULsCcBx717hmWKNgY8XrUCO5ddnThMrSq1mj52ppKC6xKqA8zIyMab0fdxLu0LdwM1BJ/vUkI9WW9PA2suFl6KH9oaWpc9LGTyT0rZSWdUgvinbkUFPAEtHtHgdjAY/uSMEcBnwLfM/hqvkZGWBtfw7Ap5RzOlWPXcjSgKdM/SgyaSqGaGCL7obCm2gyqvM2WYont3KFnWKBOcp9HNf2b1lbP18vBsdPIa2V7RML29HoDgRiMiIOxcz9Jtdg5u196FE/b7HVwyC4hZ3XWAkhvM6dvvSzfFBa7SznLYvdvMJ+va4fIDzpALnrWzQCLlZ4DPRhLqATKcxx92a9Qjeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4610.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(86362001)(38350700002)(26005)(2616005)(8676002)(53546011)(956004)(6666004)(508600001)(66946007)(36916002)(66556008)(52116002)(186003)(2906002)(6486002)(786003)(16576012)(316002)(66476007)(83380400001)(5660300002)(66574015)(38100700002)(110136005)(8936002)(75432002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0ZaTGhiVVIxUW5PWU9LaWhNL0puQ08wcW5tZjZibTFaa0NGNGhKTnVVWHBk?=
 =?utf-8?B?Q0xiRVVhRS9OMFc0MWZtdStSSXJSQllWNHBYenZoUGcwRVN0SUc0UjJIN3Qw?=
 =?utf-8?B?TkFNMTJXOG83TTdJZjQzaVVpOTY2cy9NRFVpbHYzUlVsQWxvTnhLYWwzanAv?=
 =?utf-8?B?TFJDZFoxdFNRR2ovNVliNUV1SFRLcDRVMEZrM3dqWkphbmNWRTBrd05Ha0U1?=
 =?utf-8?B?aEpTRm8ycHpTeHlkK2g0SkljeWxtNlUweFJNMzRNcVZ2YVMrOGZnUmFyOWVX?=
 =?utf-8?B?N01QWDBQYXFnK0VXcVdWOENwM2Zvc3IvSUFiRDNUNWVESVp3WEllMGo0OVJz?=
 =?utf-8?B?RGJaMDV0WUozcUgweDdKb2JxWmFybzV4OHU4MkxFYjFua3V4UlloZXlQUnRk?=
 =?utf-8?B?QmphYVdnVkd6N1V3THRRU0pscjJjbjJVQkhDc2pCeTlBQ1dPbFA5YTdiVDZk?=
 =?utf-8?B?NGUwOG1od0NDby8xaW5ZUStlQ3IvbVZ3Zlo3c2Q4RDZGejlxbGxDNVdXRFpU?=
 =?utf-8?B?Ui9YU2xlbldpa3NqUGxsTkt2S2hHYWVubWFubnlKVjEvVnZRUDlQZ2ZLZDhw?=
 =?utf-8?B?V1lmRlJQR3lJa0gzcHhUNUN5SHlnOWNqNjR6Qmk3bk54ZzdibkNQVW5xZDZo?=
 =?utf-8?B?UW9GVEM5WDJzVm9Na3ZKeHpVTWVhdXN5cFlDNk1ldzlnc2JvVjRVemhwNC9h?=
 =?utf-8?B?aUthL2xMaS93alV2RmRNMys0RTRJNG9pcGJtcnNFN2lmTUphM1A2V1JWcGFm?=
 =?utf-8?B?Q080M0pvU01NVy9YS3UzaWtnZEhkK3NuM2dvYnlUaGgwNjhjR1dVYTdwaWdv?=
 =?utf-8?B?WnlyNzduVkRvN29yWUVwQXdNU3lqQmFKWFpwQWw3cC9MbEprREt2ajRwc0R0?=
 =?utf-8?B?WU1XOWdobjgvTnZnVmZveHdZdGJpZm4wYkcxSzRPa1JEQURhSUFLTkN5TS9C?=
 =?utf-8?B?WWc1SW14R0F3WEdyTlFJRjlDN3ViREpXbXUvbzE3Rk0yKzYxWFJGU2JCckFJ?=
 =?utf-8?B?dy9zSjFXdkp2NUVLaUN4WWNWRVlnblRoVFpqSFQwMGxwUTEzOGVrTUdGKzFR?=
 =?utf-8?B?TCtHT29WbjRRQ3lqL0laQWdaRmNxclI2TW8zTUpna1U4blArejExZ1JYUVJx?=
 =?utf-8?B?UGxCNW1LR2U3b1loTWVHNFR4dXVNT2UvNWUrYWlqTjdoVjhETUxyWUlHekc4?=
 =?utf-8?B?MzFzWkNrZU96dlZVNXYrTzM0dEN4MW9mMjZYS3pmWHRPaXdWdUFWL29aVVpY?=
 =?utf-8?B?VFh1ZHBHNmF1M3FGeFdtS2ZCTWxCc2RtaVViVTRLMFdzeUJHeEhyM2JPVWo5?=
 =?utf-8?B?bE94dzdTbkduZjlmMktrVG9hSFlWdHpnS3RYb3R6eTZmOTlSVG5UWkdHTkhC?=
 =?utf-8?B?blFXZWRkaVl0enVIQjZLNGhhN1lRbmFtNUtQZnFmSlhYeXNoYm5nY0s2VVVR?=
 =?utf-8?B?cFBkQnJMb3RqYjgrMGJ0NVZQZTFnc2JqWkhPaFJQMUx6VVZkTjdaelBuU3JE?=
 =?utf-8?B?ZjFBekYrYVZyNm5CcDJRZ1ZKYXVoRFlMZ3h2NytOWDNOQ3BGMEJhQndrTGhB?=
 =?utf-8?B?cDlWQ1BaY2JHOGNENjZGZDhGN0hYWEc5Rm1Ca3YrVWpuY0YyMmw1WFNSd0ta?=
 =?utf-8?B?QXp0TkQ3eElubUlYQXFIWURZZzNlc0pMSFp0aW00S3JzSzFYd2d1SWUwVWRW?=
 =?utf-8?B?QTVaZ0xtU0ZVbDF0d2FBNDUwWXRFT0hiTXFBWXlMUHRoWnpqZmpBdnFORENk?=
 =?utf-8?B?Zi8rbjZDcE1TTE1Ncno0azFYYjBuSkh3T2RidUNrelFtR0pvR0VUY1I2NGll?=
 =?utf-8?B?NldCblYva0Z5RWVoU3I4K0dibk9EeVhkVVo4MVk4Zm84YXlna2hMdVlXVkRq?=
 =?utf-8?B?a0pXSlhXOGpMNXhNaGtWV1pmN2c3SXlCMTBIVmUrbmhzK3BSenNZdGNJUG01?=
 =?utf-8?B?bWZMbzJ2TnpOb0RTWUxZN0ozRk4vellsMkNpbWxrZVRKbndldjdEMmV4RDBB?=
 =?utf-8?B?TGw5Qyt0RVFBPT0=?=
X-OriginatorOrg: cooper.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c5f5139-0212-43d8-c5b3-08d99589032d
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4610.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 18:23:14.8962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7a2082-6807-4114-b3e6-7e241d1469a2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: daniel.mezhiborsky@cooper.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR18MB4658
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2020-05-20 at 11:48 +0100, Robert Milkowski wrote:
> Polite ping...
> 
> > -----Original Message-----
> > From: Robert Milkowski <rmilkowski@gmail.com>
> > Sent: 14 May 2020 21:39
> > To: linux-nfs@vger.kernel.org; trond.myklebust@hammerspace.com;
> > 'Chuck
> > Lever' <chuck.lever@oracle.com>; 'Schumaker, Anna'
> > <Anna.Schumaker@netapp.com>
> > Subject: RE: NFS v4 + kerberos: 4 minute window of slowness
> > 
> > +Trond, Chuck, Anna
> > 
> > 
> > Ping...
> > 
> > > -----Original Message-----
> > > From: Robert Milkowski <rmilkowski@gmail.com>
> > > Sent: 05 May 2020 18:35
> > > To: linux-nfs@vger.kernel.org
> > > Subject: NFS v4 + kerberos: 4 minute window of slowness
> > > 
> > > Hi,
> > > 
> > > Currently the last 4 minutes before kernel gss context expires,
> > > all
> > > writes to NFSv4 are synchronous and all dirty pages associated
> > > with
> > > the file being written to are being destaged.
> > > This will continue for the 4 minutes until the context expires,
> > > at
> > > which point it gets refreshed and everything gets back to normal.
> > > 
> > > The rpc.gssd by default sets the timeout to match the Kerberos
> > > service
> > > ticket, but this can be lowered by using -t option.
> > > In fact many sites set it to lower value, like for example 30
> > > minutes.
> > > This means that every 30 minutes, the last 4 minutes results in
> > > severely slower writes (assuming these are buffered - no O_DSYNC,
> > etc.).
> > > In extreme case, when one sets the timeout to 5 minutes, during
> > > the 4
> > > minutes out of the minutes, there will be the slowness observed.
> > > 
> > > 
> > > I understand the idea behind this mechanism - I guess it tries to
> > > avoid situation when a gss context can't be refreshed (due to
> > > error or
> > > account disabled, etc.), and it expires suddenly nfs client
> > > wouldn't
> > > be able to destage all the buffered writes. The way it is
> > > currently
> > > implemented though is rather crude.
> > > In my opinion, instead of making everything slow for the whole 4
> > > minutes, it should first try to refresh the context immediately
> > > and if
> > > successful things go back to normal, if it can't refresh the
> > > context
> > > then it should continue with the previous one and revert to the
> > > current behaviour. I implemented a naïve quick fix which does
> > > exactly
> > > that (attached at the end of this email).
> > > 
> > > 
> > > How to re-produce.
> > > 
> > > 
> > > $ uname -r
> > > 5.7.0-rc4+
> > > 
> > > $ grep -- -t /etc/sysconfig/nfs
> > > RPCGSSDARGS="-t 300"
> > > 
> > > I'm setting it to 5 minutes so I can quickly see the behaviour
> > > without
> > > having to wait for too long.
> > > 
> > > 
> > > Now, let's generate a small write every 10s to a file on
> > > nfsv4,sec=krb5 filesystem and record how long each write takes.
> > > Since these are buffered writes it should be very quick most of
> > > the
> > > time.
> > > 
> > > $ while [ 1 ]; do strace -qq -tT -v -e trace=write /bin/echo aa
> > > >f1;
> > > rm f1; sleep 10; done
> > > 
> > > 15:22:41 write(1, "aa\n", 3)            = 3 <0.000108>
> > > 15:22:51 write(1, "aa\n", 3)            = 3 <0.000113>
> > > 15:23:01 write(1, "aa\n", 3)            = 3 <0.000111>
> > > 15:23:11 write(1, "aa\n", 3)            = 3 <0.000112>
> > > 15:23:21 write(1, "aa\n", 3)            = 3 <0.001510>     <<<<<<
> > > becomes
> > > slow
> > > 15:23:31 write(1, "aa\n", 3)            = 3 <0.001622>
> > > 15:23:41 write(1, "aa\n", 3)            = 3 <0.001553>
> > > 15:23:51 write(1, "aa\n", 3)            = 3 <0.001495>
> > > ...
> > > 15:27:01 write(1, "aa\n", 3)            = 3 <0.001528>
> > > 15:27:12 write(1, "aa\n", 3)            = 3 <0.001553>
> > > 15:27:22 write(1, "aa\n", 3)            = 3 <0.000104>     <<<<<<
> > > becomes
> > > fast again
> > > 15:27:32 write(1, "aa\n", 3)            = 3 <0.000125>
> > > 15:27:42 write(1, "aa\n", 3)            = 3 <0.000129>
> > > 15:27:52 write(1, "aa\n", 3)            = 3 <0.000113>
> > > 15:28:02 write(1, "aa\n", 3)            = 3 <0.000112>
> > > 15:28:12 write(1, "aa\n", 3)            = 3 <0.000112>
> > > 15:28:22 write(1, "aa\n", 3)            = 3 <0.001510>     <<<<<<
> > > slow
> > > ...
> > > 15:32:02 write(1, "aa\n", 3)            = 3 <0.001501>
> > > 15:32:12 write(1, "aa\n", 3)            = 3 <0.001440>
> > > 15:32:22 write(1, "aa\n", 3)            = 3 <0.000136>     <<<<<<
> > > fast
> > > 15:32:32 write(1, "aa\n", 3)            = 3 <0.000109>
> > > 15:32:42 write(1, "aa\n", 3)            = 3 <0.000110>
> > > 15:32:52 write(1, "aa\n", 3)            = 3 <0.000112>
> > > 15:33:02 write(1, "aa\n", 3)            = 3 <0.000103>
> > > 15:33:12 write(1, "aa\n", 3)            = 3 <0.000112>
> > > 15:33:22 write(1, "aa\n", 3)            = 3 <0.001405>     <<<<<<
> > > slow
> > > 15:33:32 write(1, "aa\n", 3)            = 3 <0.001393>
> > > 15:33:42 write(1, "aa\n", 3)            = 3 <0.001479>
> > > ...
> > > 
> > > 
> > > 
> > > So we have 4 minute long windows of slowness followed by 1 minute
> > > window when writes are fast.
> > > 
> > > 	15:23:21  -  15:27:22        slow
> > > 	15:27:22  -  15:28:22        fast
> > > 	15:28:22  -  15:32:22        slow
> > > 	15:32:22  -  15:33:22        fast
> > > 
> > > 
> > > 
> > > After some tracing with systemtap and looking at the source code,
> > > I
> > > found where the issue is coming from.
> > > The nfs_file_write() function ends up calling
> > > nfs_ctx_key_to_expire()
> > > on each write, which in turn calls gss_key_timeout() which has
> > > hard-coded value of 240s
> > > (GSS_KEY_EXPIRE_TIMEO/gss_key_expire_timeo).
> > > 
> > > 
> > > nfs_file_write()
> > > ...
> > >         result = nfs_key_timeout_notify(file, inode);
> > >         if (result)
> > >                 return result;
> > > ...
> > >         if (nfs_need_check_write(file, inode)) {
> > >                 int err = nfs_wb_all(inode); ...
> > > 
> > > 
> > > /*
> > >  * Avoid buffered writes when a open context credential's key
> > > would
> > >  * expire soon.
> > >  *
> > >  * Returns -EACCES if the key will expire within
> > > RPC_KEY_EXPIRE_FAIL.
> > >  *
> > >  * Return 0 and set a credential flag which triggers the inode to
> > > flush
> > >  * and performs  NFS_FILE_SYNC writes if the key will expired
> > > within
> > >  * RPC_KEY_EXPIRE_TIMEO.
> > >  */
> > > int
> > > nfs_key_timeout_notify(struct file *filp, struct inode *inode) {
> > >         struct nfs_open_context *ctx =
> > > nfs_file_open_context(filp);
> > > 
> > >         if (nfs_ctx_key_to_expire(ctx, inode) &&
> > >             !ctx->ll_cred)
> > >                 /* Already expired! */
> > >                 return -EACCES;
> > >         return 0;
> > > }
> > > 
> > > 
> > > nfs_need_check_write()
> > > ...
> > >         if (nfs_ctx_key_to_expire(ctx, inode))
> > >                 return 1;
> > >         return 0;
> > > 
> > > 
> > > 
> > > nfs_write_end()
> > > ...
> > >         if (nfs_ctx_key_to_expire(ctx, mapping->host)) {
> > >                 status = nfs_wb_all(mapping->host); ...
> > > 
> > > 
> > > 
> > > /*
> > >  * Test if the open context credential key is marked to expire
> > > soon.
> > >  */
> > > bool nfs_ctx_key_to_expire(struct nfs_open_context *ctx, struct
> > > inode
> > > *inode)
> > > {
> > >         struct rpc_auth *auth = NFS_SERVER(inode)->client-
> > > >cl_auth;
> > >         struct rpc_cred *cred = ctx->ll_cred;
> > >         struct auth_cred acred = {
> > >                 .cred = ctx->cred,
> > >         };
> > > 
> > >         if (cred && !cred->cr_ops->crmatch(&acred, cred, 0)) {
> > >                 put_rpccred(cred);
> > >                 ctx->ll_cred = NULL;
> > >                 cred = NULL;
> > >         }
> > >         if (!cred)
> > >                 cred = auth->au_ops->lookup_cred(auth, &acred,
> > > 0);
> > >         if (!cred || IS_ERR(cred))
> > >                 return true;
> > >         ctx->ll_cred = cred;
> > >         return !!(cred->cr_ops->crkey_timeout &&
> > >                   cred->cr_ops->crkey_timeout(cred));
> > > }
> > > 
> > > 
> > > 
> > > net/sunrpc/auth_gss/auth_gss.c: .crkey_timeout          =
> > > gss_key_timeout,
> > > 
> > > 
> > > /*
> > >  * Returns -EACCES if GSS context is NULL or will expire within
> > > the
> > >  * timeout (miliseconds)
> > >  */
> > > static int
> > > gss_key_timeout(struct rpc_cred *rc)
> > > {
> > >         struct gss_cred *gss_cred = container_of(rc, struct
> > > gss_cred,
> > > gc_base);
> > >         struct gss_cl_ctx *ctx;
> > >         unsigned long timeout = jiffies + (gss_key_expire_timeo *
> > > HZ);
> > >         int ret = 0;
> > > 
> > >         rcu_read_lock();
> > >         ctx = rcu_dereference(gss_cred->gc_ctx);
> > >         if (!ctx || time_after(timeout, ctx->gc_expiry))
> > >                 ret = -EACCES;
> > >         rcu_read_unlock();
> > > 
> > >         return ret;
> > > }
> > > 
> > > 
> > > 
> > > 
> > > #define GSS_KEY_EXPIRE_TIMEO 240
> > > static unsigned int gss_key_expire_timeo = GSS_KEY_EXPIRE_TIMEO;
> > > 
> > > 
> > > 
> > > 
> > > 
> > > A naïve attempt at a fix:
> > > 
> > > 
> > > diff --git a/net/sunrpc/auth_gss/auth_gss.c
> > > b/net/sunrpc/auth_gss/auth_gss.c index 25fbd8d9de74..864661bdfdf3
> > > 100644
> > > --- a/net/sunrpc/auth_gss/auth_gss.c
> > > +++ b/net/sunrpc/auth_gss/auth_gss.c
> > > @@ -1477,6 +1477,8 @@ gss_key_timeout(struct rpc_cred *rc)
> > > 
> > >         rcu_read_lock();
> > >         ctx = rcu_dereference(gss_cred->gc_ctx);
> > > +        if (ctx && time_after(timeout + (60 * HZ), ctx-
> > > >gc_expiry))
> > > +               clear_bit(RPCAUTH_CRED_UPTODATE, &rc->cr_flags);
> > >         if (!ctx || time_after(timeout, ctx->gc_expiry))
> > >                 ret = -EACCES;
> > >         rcu_read_unlock();
> > > 
> > > 
> > > 
> > > 
> > > With the above patch, if there is a write within 300s before a
> > > context
> > > is to expire (use RPCGSSDARGS="-t 400" or any value larger than
> > > 300 to
> > > test), it will now try to refresh the context and if successful
> > > then
> > > writes will be fast again (assuming -t option is >300s and/or krb
> > > ticket is valid for more than 300s).
> > > 
> > > What I haven't tested nor analysed code is what would happen if
> > > it now
> > > fails to refresh the context, but after a quick glance at
> > > gss_refresh() it does seem it would continue using the previous
> > cred...
> > > Is this the correct approach to fix the issue, or can you suggest
> > > some
> > > other approach?
> > > 
> > > 
> > > 
> > > --
> > > Robert Milkowski
> 
> 

Hello all, is this behavior something that can be looked into again? In
some applications, it's preferable to have a short timeout for frequent
auth refreshes.

Thank you!
Dan Mezhiborsky

