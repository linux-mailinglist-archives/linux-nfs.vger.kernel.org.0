Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49C4441FF6
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Nov 2021 19:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhKASZN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Nov 2021 14:25:13 -0400
Received: from mail-bn7nam10on2124.outbound.protection.outlook.com ([40.107.92.124]:43297
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229528AbhKASZM (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 1 Nov 2021 14:25:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfW9zvhPCxJjE2ob9avTOd8tBUz6QcmXDfIovA+z82CEN7koNFajOhABeXrNW58MFS7bTr6rB4RfC7Mdz3qEFg7rC3RrEMDD4OuLZM5wqG73hMH9ZvSvXBJZ/H/YMoDTCZnRJJtUsOXAQJ3qhZiQ15lI7lFMEC6sZ3eje38lwjZGyqRBXBiFrGOyPUqgHG03JGIsu7NWJh69oKURKs+6J24UmnAoJn/yBB3g02VqrTLDDUpez9x3uGQfBWCsl3jRozTD9JNwQ7zDttvHtkEO+J6HAFgNdxclM91O2wS3S2fi0JwsMe6J62w+OiUqeu8AxQu5Di1AolO9VNu8oDkpxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrFPw21jAMJcEcMqCbWWeSBAJQya+p14kqDQH841S2Y=;
 b=Bt8IDBf4TgbciZyx9VyFlG7eXWD/qv7b8Pve2kug2UmYCNzq7BOXiVDIDrE1SKcyLQnmLG4zVRYF6x3AFWyKRTCrwzkh00mPSy8OeGxPSBeNNXCjTsh6ShKt6kW+yF0KR2YQ7jaS1KE4qq+N//QsRpUVHhU6vfx3NZ7IOai9eITZqwX0I2qIGb4sBSTKaFiW0TYpMQrqKtFhttjJj5xLhQfGcLgkZnrl8mY1F4kSPhpionq9evcAzzRrzVYqJ8RrWMT5C9neWwlsPYgoloGX79NVhSdnYdNdHvhv8ujIwuNJtstalfld6CBPtSpOmuNFqPWGBrwmFbAeu1PlyWeF5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrFPw21jAMJcEcMqCbWWeSBAJQya+p14kqDQH841S2Y=;
 b=mP2fJH+MNpyxMKOKochPeW+StxijO0C4ezLCmPwSC9afEc0kGzMTpWLwU2WB0O35jq0zuplgABBzziQv74rXMyrzkNryYj4otffdsUdQVNWgNlptuQNttLnj8OnYGiJwaFyXeDyuoi/MeVYUHYYUek2uRRzniErPZAB00EmHjYQ=
Authentication-Results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=rutgers.edu;
Received: from BL0PR14MB3588.namprd14.prod.outlook.com (2603:10b6:208:1cb::7)
 by BL0PR14MB3746.namprd14.prod.outlook.com (2603:10b6:208:1c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Mon, 1 Nov
 2021 18:22:38 +0000
Received: from BL0PR14MB3588.namprd14.prod.outlook.com
 ([fe80::a4c4:e5de:c2a9:914b]) by BL0PR14MB3588.namprd14.prod.outlook.com
 ([fe80::a4c4:e5de:c2a9:914b%2]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 18:22:38 +0000
Content-Type: text/plain;
        charset=utf-8
Subject: Re: server-to-server copy by default
From:   Charles Hedrick <hedrick@rutgers.edu>
In-Reply-To: <20211020155421.GC597@fieldses.org>
Date:   Mon, 1 Nov 2021 14:22:37 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        dai.ngo@oracle.com,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Steve Dickson <steved@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C0088A79-6936-4764-8ADB-4D6C32054265@rutgers.edu>
References: <20211020155421.GC597@fieldses.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-ClientProxiedBy: BL1PR13CA0296.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::31) To BL0PR14MB3588.namprd14.prod.outlook.com
 (2603:10b6:208:1cb::7)
MIME-Version: 1.0
Received: from smtpclient.apple (2620:0:d60:ac1a::a) by BL1PR13CA0296.namprd13.prod.outlook.com (2603:10b6:208:2bc::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.5 via Frontend Transport; Mon, 1 Nov 2021 18:22:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9bdf8a4-da25-4b5b-4dec-08d99d649567
X-MS-TrafficTypeDiagnostic: BL0PR14MB3746:
X-Microsoft-Antispam-PRVS: <BL0PR14MB3746356EC71602C59B1F2381AA8A9@BL0PR14MB3746.namprd14.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xCUf47URRhaE14gkzbKaNIkSKTH55TzgFfb6Q2wA2s/sWmGuOyP1Kign3bfT7W4Dq6owskZaAdx97FsFIBhkBVcr2oGZAygXCZ+r9FD5BZ4lvCUSAtJFz0IH5pvlWwm89rMsy7NyEiHq47ShR0IgY72Bby+aePhmpiRETO1guoAZvV/e0ndDAsVVhEyWBCb5ss2lbT33vfVhlfeVDgvSwu4oOldKiMN/0WTaHejOiQ2eGy2Q7Ub8yR3Si7fmEDF+E4uTQstEltwYbSYFDExE3gn6SuWyPRNLaOjEU2toNtssZHGjq4X+0yh0PqFO0/FYh/X78MpYypydUvol+MbplN5USCTRVTcT3iUJLBRHlDbqZgUiKq80p+s8NogTzntLLYKH1jcdKHuqDqH4dpjbmg34rYOsfdPj+aRt6PMn0//bV0DeC4/mrMirYwsXxtN1WVzhjfIAQGGhH3oX1RiPWV/rwzX8Ua4UdI8uX4aV9CXf8ydiY5hyyGObzFGj+/+iDUo3gyBrOOOGc0VBw+DE0ILDbTmlBvwihsemzxuNSzHIOl8hKlFnhLB8Yc9EBE9AwPzra/fvWjgUEOlKQJORFERzUesfztrztEhO2aDPMq/0o7yPGtjc6MiC2cl61dQSGsiCs29YRoVac2H5Zi2K0QbG5QSvu0X+r+t6MBVzpETKPh2cevU9+NSd6goro+2gPzt7mDpJpF7FJaOi9Nh0Fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR14MB3588.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(52116002)(53546011)(36756003)(6506007)(2906002)(38100700002)(4326008)(86362001)(508600001)(6916009)(54906003)(8676002)(8936002)(2616005)(316002)(5660300002)(33656002)(786003)(75432002)(6512007)(66476007)(66556008)(66946007)(83380400001)(186003)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yys1bW9wR1N6bmhXbTdoTExSdDRHV2ExQi9BdGFuUmYvTFJRd2h1RkIwaUMr?=
 =?utf-8?B?VnJ3aEtWZ1d5V1JTejczcU9qVTJuWWh1cXBVcjhPV1k1TlhHQkhPTFpQcWkv?=
 =?utf-8?B?ZjEvZ040ZlZZQk5Gc3FCYW1qenpSNDIrY0hCeE85UDVPR0YyeXFham16SmVZ?=
 =?utf-8?B?cDlDUFd2UUQ1TFdiTmQ1cFloeGlDL0RPVmdRMllSTVM5alpzc29Ed2hHODFW?=
 =?utf-8?B?RnRSMDhtZzVNUmpTeS9CRlJFcHRGelJVR0RLZlBWY3k5QXNDMmVVZmlLV3gw?=
 =?utf-8?B?WDl4NHFTcllDVE94U0tuZU9xRnh5MnhJem12d3RBalhIMW8vTWROYnB5ZWs5?=
 =?utf-8?B?WDA2QUFqR0hzbnMzZGVTOWxiZlhwR09JL2VnZ1RpbzZUbUNQbUE3VXhmcVNG?=
 =?utf-8?B?Sm1hMlRFbUlub0RoTldFRlhMVkREbXJ4WGxSNzFacFVxU0d2aGxzRGhKckRt?=
 =?utf-8?B?SlN1Q2lUcjN0bk9ubzFNNmVKUUJMQ0UrcUx6SERjWW1sNnJJUmxnNVI0Qkdx?=
 =?utf-8?B?eG1XbU93UVN1UUlENUEwZUkyQ2VSUmRjZitjaWdHZWgxempOenErTmxsbkVi?=
 =?utf-8?B?MEhpdEtrUHk2Z000Zi96M2dab0thMWRZL0NiSXBPWndNTVlSLzRGeUdBSmlk?=
 =?utf-8?B?WnNRMnl0OG81bmsrL1E4RXhLS2JUYUZQNFRWbGZwcnNrNk9QeDY1eHZMQnlM?=
 =?utf-8?B?NXdKb1dhUC9KYVA4UmtnSE1Zcnhqb3c1UC9MdG1PVzNRQjRpU2pJck1DaWxM?=
 =?utf-8?B?VjQ2STN3S1A5bm1hdU1ZMnhCVG9ORFRrckVQNUxxbWdsRG5mR2ZEUzB3bE1D?=
 =?utf-8?B?S1I3K0JBaU1ZMGE2NmhUWDJsZmVDWW1tMmU1YXhWQXlzWk80ZVBDYjArSjY0?=
 =?utf-8?B?VEJIQUdFbXZKTWFpbWNGeEllWEJvSDlwSUtZYlJ2QU5zMzZJa3h1RklpeDVa?=
 =?utf-8?B?c012aDBxSHRYcnFQZTFzaktQSDJTWFVVVU9tMnZieWg0SzREUy9DbWljS2ZY?=
 =?utf-8?B?Y1NHZ3ZtMmt6b2VLQW1qS2dwbldDdk0wY3hGL1hJa09zc0RiWUhhYjJ5TDFh?=
 =?utf-8?B?Y29nK2NtQVdVN1BhemRBMjN3RkFvbFJaMGtrOFA4S01DMElZUm54cElwVDNQ?=
 =?utf-8?B?QlNPNWNFUWdSSFBWNXFDMXpMUlFKc0g0RWs2bzVqM3VhcGI4MElTbU14NEto?=
 =?utf-8?B?UGFvWU9RZVJtb2UycThnTHlkUnJhKzVaRUw2Z1dadWN2MHpaWHd3Nmh6VlRu?=
 =?utf-8?B?dXlnc3lsZjA0aVZoVDFwNFRiRStwdDlLNFpwdmpidjQ5eTcwR0UrKytyRjdO?=
 =?utf-8?B?TG5YSGFSakE1cGpGeXExOTd2dHVEOStLbmNLTnM1OTNJNHBqbHNNRHVseEVW?=
 =?utf-8?B?YmFlMXMwdmM0bU9TUnMvcm1BZnowTmI0OENhRzRTbHBMRHRpZ1pna2lnUEJy?=
 =?utf-8?B?QVprNHVxSXRGUlpWR1VrUVlsTXFjUGNmSVJ5YXhpTmhHaTc0Nk5pVlErYy9w?=
 =?utf-8?B?L1BjTXZncmdXQzhHM1BZcW5oRkJQdW9tVkppc0tNay9BN0Rtdm5rM1FKUlVN?=
 =?utf-8?B?c0Jtak9vVC9MVnhDOFlFTXlHRC9zV2VlNUtLMm5uc1dadlhyY0huclNQaGQ3?=
 =?utf-8?B?L1RacXF5Tm5nZUk1cUdlcFdrQ29nSEQ4R3lVRDdyckRuS3k0RnJ6SEZpNFZy?=
 =?utf-8?B?aFdUalZseEEwRnlnWjBUQ1ZDUUluZnJNUUxzbXVXZndiNldhbVNRNnE2MWEz?=
 =?utf-8?B?bTdkWElNK2E3WDlSM3ltekZoQU13UnBteE9uMGk1N3p5Y0pHY01BckZiWU9a?=
 =?utf-8?B?M1R0VVVHNXhNMklMVFRlN0RQUjVHanhNenZTWklBZUN4aGY0QWQxSkRoa2ps?=
 =?utf-8?B?SE5pUnNRdnVNUmRhQk5YZ1J5VUgwZElPanIzVGdrWkYxb2V2L0JsNHBzUEVv?=
 =?utf-8?B?eTI0bXZ6ZWlDajhKWGYvc29LVDJjSFk4VnhRVExjRUo2ZVpKMDRHa1lDY0F0?=
 =?utf-8?B?OFlGanlST0NGVXpHSFdBUTZYeU9Wa3hBWVVLZlkrWmFrbUp1c0FHV0w2YldK?=
 =?utf-8?B?UVdxV3hvanJ3MnB6Sk5JNGFCYXpyWWp5Z3hqMDQwYmxYUHF1ZW5ranJiWUd0?=
 =?utf-8?B?VG5ETnk1ZXZ3R3NtY1dCVUhNUzhXNEJZaFpOZmQ0R3ZrVDg5bDRxVEdEUEU2?=
 =?utf-8?Q?QksHVu20NH8CW6SfOMZpJ/I8lm502KQ0G3DRQYVBp1k3?=
X-OriginatorOrg: rutgers.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: b9bdf8a4-da25-4b5b-4dec-08d99d649567
X-MS-Exchange-CrossTenant-AuthSource: BL0PR14MB3588.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 18:22:38.0881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LgAjkmr6uFQJj7pXSPHDhc+G+MJ1Ht7TK+KYMBQ/XoUMzeIaFak94nGR7B8TjxSCoBm2nXIMlQulWH/T8Zu50w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR14MB3746
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I am in general concerned about turning on new features before basic ones w=
ork reliably. We=E2=80=99ve had enough different failures that we=E2=80=99v=
e backup up to NFS 3 for file systems with heavy use.

We first tried turning off delegation. That helped a lot. But we just ran i=
nto a two different machine hung trying to lock Chome=E2=80=99s profile. (I=
 sent a bit of information on that one previously.) We had to restart NFS o=
n the server to fix it, and that caused us to lose a bunch of VMs. (That sh=
ouldn=E2=80=99t have happened. It looks like ESX misbehaved.) If I could tu=
rn off NFS4 locking I would.

> On Oct 20, 2021, at 11:54 AM, J. Bruce Fields <bfields@fieldses.org> wrot=
e:
>=20
> knfsd has supported server-to-server copy for a couple years (since
> 5.5).  You have set a module parameter to enable it.  I'm getting asked
> when we could turn that parameter on by default.
>=20
> I've got a couple vague criteria: one just general maturity, the other a
> security question:
>=20
> 1. General maturity: the only reports I recall seeing are from testers.
> Is anyone using this?  Does it work for them?  Do they find a benefit?
> Maybe we could turn it on by default in one distro (Fedora?) and promote
> it a little and see what that turns up?
>=20
> 2. Security question: with server-to-server copy enabled, you can send
> the server a COPY call with any random address, and the server will
> mount that address, open a file, and read from it.  Is that safe?
>=20
> Normally we only mount servers that were chosen by root.  Here we'll
> mount any random server that some client told us to.  What's the worst
> that random server can do?  Do we trust our xdr decoding?  Can it DOS us
> by throwing the client's state recovery code into some loop with weird
> error returns?  Etc.
>=20
> Maybe it's fine.  I'm OK with some level of risk.  I just want to make
> sure somebody's thought this through.
>=20
> There's also interest in allowing unprivileged NFS mounts, but I don't
> think we've turned that on yet, partly for similar reasons.  This is a
> subset of that problem.
>=20
> --b.

