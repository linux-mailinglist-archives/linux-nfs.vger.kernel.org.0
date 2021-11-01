Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7E6442109
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Nov 2021 20:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhKATrI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Nov 2021 15:47:08 -0400
Received: from mail-dm6nam11on2120.outbound.protection.outlook.com ([40.107.223.120]:63456
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229723AbhKATrH (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 1 Nov 2021 15:47:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S49pv7JGF50c7C8L4xZq2TJtv1NPdIodHYea4revNZScKSkoYkxmzKVjvEBKOH3ng/bUXPAJshE4Jh0+ZXqon5q9NkMr+SqefGKbB9X8srcNxD0ff8xbMOhPJsj5KLTeWKTUqEN+mCEW3mkEhrRRtD+/0qDzHJs5SctY/v+8Zl61ffr66yhuMcRmKWf6AH5STVLn+dabYU9zrc4G54WI9v1F90jQHSJCz91/i3lyGWD7nHKRDJKMvexgvT6BtT9/crWDv9Xqv5TQSBGT41krRZlQh95XUtsB+fCQh+HZYeB2eQr/3vM3w9/udSgUO1x+y6ba5s/zkCILLp5MCy8xLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66Rmqc5dpMDZnmtO1DzWmUBe6IOT08CX4PHWUgc7B8w=;
 b=jJzm0YYqF/uysoT6QR+sqMilshJe4M8i9eVqjU0TdDxc2B3YD+IU7sFLMCwKy8T8HZfj9bgrhFJmLBZEZUhyAjHH0bz2OdszBH8N/p97TakX7R2ad/HzNk17m7RTGt0yKYwbQIa91jIfGndKsJmMFtKswVHXGx0JDYhX86xGm6GEenKqlIw/2KFw8vcSfHedFw5Sn54hyZFXzb0bnqz4MRxhaNVVpQFamz8tJBckiEEWnwnzxElZzmU8xPa1J9A32CB69um4dP/GR5a7otDmiZOhuvQMSZ+q+6OcxtExJPdrhjhjGI4I+BByyB4nPvTrlfHWWfwTgrm4xRRKzz+hzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66Rmqc5dpMDZnmtO1DzWmUBe6IOT08CX4PHWUgc7B8w=;
 b=HlcirJyydAmr0x9K3RtHd43Ll07PwRY5adit0Xz7zr5mUJiVxYWWMjzp+4n8xFTKReVujBVAztG6Dv9aVMmwCXQeOrKuTfycGqltSkaHc0CkBlrxjBRGv814WKXW0STjk8k/mcl0acCLwsD+srusVRgItriFjTvSAX2LkWkEJV8=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=rutgers.edu;
Received: from BL0PR14MB3588.namprd14.prod.outlook.com (2603:10b6:208:1cb::7)
 by MN2PR14MB4126.namprd14.prod.outlook.com (2603:10b6:208:1d3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Mon, 1 Nov
 2021 19:44:33 +0000
Received: from BL0PR14MB3588.namprd14.prod.outlook.com
 ([fe80::a4c4:e5de:c2a9:914b]) by BL0PR14MB3588.namprd14.prod.outlook.com
 ([fe80::a4c4:e5de:c2a9:914b%2]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 19:44:33 +0000
Content-Type: text/plain;
        charset=utf-8
Subject: Re: server-to-server copy by default
From:   Charles Hedrick <hedrick@rutgers.edu>
In-Reply-To: <20f2fbf2-cce9-acc9-557d-82251aeef662@redhat.com>
Date:   Mon, 1 Nov 2021 15:44:32 -0400
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        dai.ngo@oracle.com,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EB0F9FC0-5614-4CA4-88F4-109B39D1300E@rutgers.edu>
References: <20211020155421.GC597@fieldses.org>
 <C0088A79-6936-4764-8ADB-4D6C32054265@rutgers.edu>
 <20f2fbf2-cce9-acc9-557d-82251aeef662@redhat.com>
To:     Steve Dickson <steved@redhat.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-ClientProxiedBy: MN2PR19CA0061.namprd19.prod.outlook.com
 (2603:10b6:208:19b::38) To BL0PR14MB3588.namprd14.prod.outlook.com
 (2603:10b6:208:1cb::7)
MIME-Version: 1.0
Received: from smtpclient.apple (2620:0:d60:ac1a::a) by MN2PR19CA0061.namprd19.prod.outlook.com (2603:10b6:208:19b::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Mon, 1 Nov 2021 19:44:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59a4235f-e3c0-405f-f8f8-08d99d700733
X-MS-TrafficTypeDiagnostic: MN2PR14MB4126:
X-Microsoft-Antispam-PRVS: <MN2PR14MB4126C92FFEAE3F82DD250CAAAA8A9@MN2PR14MB4126.namprd14.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RYXF7kbCOoP7gFBcxiqrn2xsXlReF0yvqmDxqBZ4dG5Q7w5bwW8/fSRyb2BkbqWPbeKbRcxiogAD8QMSqDJEe5JALUXXl4G5wlKTfwNn9SXfqfa3N44XFyy9zO88pVsWAGLvChd61IEgtbQaPxazOBKRRTqRKw7Ej3SMLWKTWENoARKy7CWTNjZvLv3Eq3b9vNLHV3pMR/P/Eh5yJnXhv6Am5S/mrm/zAWGUUb6pxwhgCWyLaFvb6aSHcg9lobnJ/kxhjV7eS7JL8g5wBpvzHMYVnB4vNXoEwZ0iIB2ZZet6sdHiRdvCYdqK8L7UXVotMlBZIOPpuUy9k9wRtI1tOwWL1QKUuGNJ+Y8Q55cWPuja0571ytrJhMK82jL0QOXoIbpy+51X3cpcUR8zMwiyeMnDOB7Y0dSITsSxLSlL5Dy5HbWiAi6B5V7dxw3yJle0eScSxQMKpZ/ZQ4rn+SD+j9mmlrtgPZZSlT+gumCbB5BJvGEld4qXKPIMQNJ7vlWMC3g0PTqjHPaieSuDUWz0piMgKLJ/1tZI3+WuTISoeIwA7kRTQPgAxKQp8oJBZz2DknS8Hi7qT6g3XyyEFD49A7WCqk0Y7Cy/UdRP+iZNkU7ldQAL/QuRg/s+R2V4a7cdVlCoLmN5GVocuh7JLHVXIoC/LZ/iKbfnHfv70xQuRcqz1D4EceKC2ewKlMA+80h07GEOQ9Gq1JRX+XgMgX0gag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR14MB3588.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(6916009)(186003)(52116002)(8936002)(36756003)(316002)(6486002)(5660300002)(786003)(4326008)(6512007)(83380400001)(508600001)(2906002)(38100700002)(53546011)(86362001)(66476007)(66556008)(54906003)(75432002)(33656002)(6506007)(66946007)(2616005)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aG9pbzNCSVVzdThWWFJLY3huZ1pTRU1MS3libUoxQkpjMS9XVHJpQXV5YnZu?=
 =?utf-8?B?ZExMeTdiZHhWeDZLQkdwZTdiclZ2NnU4V1pmbFpSOHF4cGZTcVdnS3h5WFc4?=
 =?utf-8?B?eVY1dldkZmZvak8waUpUZmRiMDQxSFZ4VjJSNWxkSDJBbkphY2Via21xRGJ5?=
 =?utf-8?B?R2RRK2FaN3lYZW42YmRXam13aHJScUN2ZEplckxvQTNOUVpLYWZOSXNta0tI?=
 =?utf-8?B?SVdSNk9xV2JnSStNTVh5TFE3Vm9ZdlFrSDhQQ0NGK203K1VZNkRQTHdDREFG?=
 =?utf-8?B?MFQwaXBPSlRZSHcyNzdrdG5NQmlQdFJOWFdlOTBQc1ZpYVBmWnBRL2JMK2JM?=
 =?utf-8?B?ZkZQWnBjdGQrY0Y3OWsrRWk3aGJDK1BmT29zeGhmZ1VYRms1Zy9jb043K2Ji?=
 =?utf-8?B?RmppSG9KTy9PcC9wSFFuUkRwZndlMmNvdUM1bzJrajBzSFJrNXdjaXlTQ2xj?=
 =?utf-8?B?VmFsbjdrUXBmd0NmejUvOXoyMmlEZURsUm5kTm5DODlIVFdtdk4zU1hUTElD?=
 =?utf-8?B?ZHNXL01rRXNDVmRnMnhMTTVJbm9UTCs2QStIbDhJVnY1eTEzY3JGUFFOeGRa?=
 =?utf-8?B?VkNJaHl4eUVrcUFqYUs0RzB3WkprWEpFci9pMHM0NEFHc29QcGZPRkovbTh0?=
 =?utf-8?B?d1hLbXJkQWJsd0tBaUtwLzRBakErUWVGTlFHUlhmVGFiUVJwOTZ5VzluUTNR?=
 =?utf-8?B?aFBHanhTUGI2VDhETjROVktxLzdmcHZ3RnhXTGswYWpaRWNnc0paUi9RdTcx?=
 =?utf-8?B?RkxyUjlURUpsTVZ6cE5yZEUrK0NQZTRwVnp0SUJrR1JFRHJUcW5ueEFoaVlm?=
 =?utf-8?B?eTZtZG5iUmxveExsUnhPNVdsc1BTeDVkZ3M0aEh5T0YzblJxSllYbFk5UldE?=
 =?utf-8?B?UmtNTVVWc1Z2dnJNTU1PRDRvVjU5MCtGOVg0UHpqRlREVXBQd2RacnQ5aU5w?=
 =?utf-8?B?bC80cDNGM0ltb1ZNUjNuOTMxMk1kVFNWZlhVTkdPTUhEbHRUREovUVNhdkFu?=
 =?utf-8?B?WjVyTm51YnRuMGx1bUlzbS8zMGk0ZWNFRHNxTm5KQkdRaXJNaWNtSlB3UkFm?=
 =?utf-8?B?ZmMyNWVNUzB4ZE5IRUt3Z1B2QWdrSTB1cStTUEJWWm9ZUld3Q1h5VHkzTGx5?=
 =?utf-8?B?azNWYlo5V29SdUpBU2ZiUldYa0ZQTDFQWHZaZGw3UmVFdFRuSXRDTm9pbldX?=
 =?utf-8?B?TjlwL1lzL1Z2UjNqMExRVDVwazZGRDg0d1FLL0pvWUJSZ3lxUmxzOW53VnN6?=
 =?utf-8?B?Wm4vYlNtWFROdE4xc1MwTFNXWFo5WWlRcXFveTI0Z1NFczdzNDRaY3Q1dEV2?=
 =?utf-8?B?UkVrNDRXNEsreEtwOVczeVNnV0tmQlc5dHRpKzROSXBLT2xYWFJoLzNrOXB0?=
 =?utf-8?B?UFU2eWpqSndVOElhZlJ5MU9zNkJGeG1pbVUrWU45RGIvZWpyN3FQYUFaWTdt?=
 =?utf-8?B?L2RlOXVLemRZTmlreThHN1lmN2xJZ1FORTJDM3czeEtFTSs2WlJhYlExR2xu?=
 =?utf-8?B?YTJxT3UrREh1K3RxK3NQcVBqQXdjQmJhV1NsNTJTVEx5MUlEM2s1QnVBQ0xN?=
 =?utf-8?B?NHB0WGtZeHVucWp6eXJmbGROc3c1N0ttYVJlbTdMNmRzMU4zUTJlU1BqSFh5?=
 =?utf-8?B?eW1GUWNrWVhlQU1wQnN4TXY3S3pYakdmcFZVK09ZeWxTQmIvenR5b0FtYml1?=
 =?utf-8?B?VGFxd1ZmUlh3dzFkaU8wRmM0dDJzZUFIQUoreXR5R2lXay8zTTZzRngxajR3?=
 =?utf-8?B?SHVDaXl6cDFRM3M4Yk5TRTVNUFgvMmkyWkdHUExOTk9BNHd1dlc4YWNoUTVW?=
 =?utf-8?B?Q0lOZWpVQ2VWRzFPbTZEUDBYaE1LQ1dhTFJwL2plTjM0YTQwY1pyaTM2R0dI?=
 =?utf-8?B?QWhlR2FOY0YrTnptSCs2QXJjVStFQTNLTS9NTzJ0TTh6RFVvOUQ0UzdITnJG?=
 =?utf-8?B?RDZ6Wmw5cmdtejdaMm1EeFA5MXpGTlBkNU5oK3N1RXhxTzFBc0N2OHF6aS9h?=
 =?utf-8?B?RGhpU0Y3a1hqMVFGZ2ZoeHArYWFBbFBmUGtuSDh5YnJGZU9VbFNoaTRHNWd1?=
 =?utf-8?B?dU1qMUpaTmZSa3JDRmRDS1FMR2tPaE5oeWxWRW5HMFJEbmtuOEgwK0Iva2dk?=
 =?utf-8?B?L1RLZG5HTWN1NG9YR2crR0d2cHFDUnA1cjVQR2pIdUZDSnBNdUR0S2dkRTRz?=
 =?utf-8?Q?2CC+oLuA9vkX3WIBMGgAYDmqY+nYg79nu0xIVSL4/39G?=
X-OriginatorOrg: rutgers.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a4235f-e3c0-405f-f8f8-08d99d700733
X-MS-Exchange-CrossTenant-AuthSource: BL0PR14MB3588.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 19:44:33.3366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/YZgVSVVFWRcfIRhvdbE3rBwlQyqSj2JCenzygYhuZbOiTT2WGvox4HWIIcjmUmPVka+pEKyzvEPiREKVndvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR14MB4126
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I don=E2=80=99t think it=E2=80=99s a common operation. But there=E2=80=99s =
enough going on that it=E2=80=99s hard to be sure.

> On Nov 1, 2021, at 3:25 PM, Steve Dickson <steved@redhat.com> wrote:
>=20
> Hello,
>=20
> On 11/1/21 14:22, Charles Hedrick wrote:
>> I am in general concerned about turning on new features before basic one=
s work reliably. We=E2=80=99ve had enough different failures that we=E2=80=
=99ve backup up to NFS 3 for file systems with heavy use.
>> We first tried turning off delegation. That helped a lot. But we just ra=
n into a two different machine hung trying to lock Chome=E2=80=99s profile.=
 (I sent a bit of information on that one previously.) We had to restart NF=
S on the server to fix it, and that caused us to lose a bunch of VMs. (That=
 shouldn=E2=80=99t have happened. It looks like ESX misbehaved.) If I could=
 turn off NFS4 locking I would.
> This is the reason I was hopping not make this a global switch
> but a per export switch...
>=20
> Question... Do you do many server to server copies in your world?
> Meaning a client coping from one server to another?
>=20
> steved.
>=20
>>> On Oct 20, 2021, at 11:54 AM, J. Bruce Fields <bfields@fieldses.org> wr=
ote:
>>>=20
>>> knfsd has supported server-to-server copy for a couple years (since
>>> 5.5).  You have set a module parameter to enable it.  I'm getting asked
>>> when we could turn that parameter on by default.
>>>=20
>>> I've got a couple vague criteria: one just general maturity, the other =
a
>>> security question:
>>>=20
>>> 1. General maturity: the only reports I recall seeing are from testers.
>>> Is anyone using this?  Does it work for them?  Do they find a benefit?
>>> Maybe we could turn it on by default in one distro (Fedora?) and promot=
e
>>> it a little and see what that turns up?
>>>=20
>>> 2. Security question: with server-to-server copy enabled, you can send
>>> the server a COPY call with any random address, and the server will
>>> mount that address, open a file, and read from it.  Is that safe?
>>>=20
>>> Normally we only mount servers that were chosen by root.  Here we'll
>>> mount any random server that some client told us to.  What's the worst
>>> that random server can do?  Do we trust our xdr decoding?  Can it DOS u=
s
>>> by throwing the client's state recovery code into some loop with weird
>>> error returns?  Etc.
>>>=20
>>> Maybe it's fine.  I'm OK with some level of risk.  I just want to make
>>> sure somebody's thought this through.
>>>=20
>>> There's also interest in allowing unprivileged NFS mounts, but I don't
>>> think we've turned that on yet, partly for similar reasons.  This is a
>>> subset of that problem.
>>>=20
>>> --b.
>=20

