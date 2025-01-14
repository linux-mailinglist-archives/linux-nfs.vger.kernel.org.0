Return-Path: <linux-nfs+bounces-9194-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1D5A102D2
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jan 2025 10:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23D11161287
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jan 2025 09:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BB722DC25;
	Tue, 14 Jan 2025 09:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDuzI9bo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E927822DC23
	for <linux-nfs@vger.kernel.org>; Tue, 14 Jan 2025 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736846086; cv=none; b=r6/6uMFC2ywVeg2j07xTw1fSl6ZCRzbAY2qg7dUCSatJCGSuHFc5R4DEaNThILnXa4vOb1OXbofV/oE2ShL3MP4lfkyggnEYpiR1WQSxeYw2kle4oABFMk9dUsWruGGOzWL/yiuwyvTDcYWzPGLXmLh2xJCJrbNYanuSIt4Ig90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736846086; c=relaxed/simple;
	bh=Ql6vXdNx4BIy3jZ4Juh22Ek6bLi01e0fEmBpWdWEQyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Rc2jh746mPOzXhG3FhmO64MNAOdnb5vNvCrR4jPu22/E+yvWAtfVmLlbY6VIIVli91lzRTpWwMP/t9FoEilDFh0mwyzvxA3DZ58+Tt1Z2Lltlaruj63haiQTYdj8onja3LA+4B/8jA3Chq4SF9zBU7KNm3Qac1Pm3hn6E1QXFYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SDuzI9bo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736846083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dsbjO3iz2deQmMVjt427EZqTuNxVEkVFhRsvYx8eF1U=;
	b=SDuzI9boyY3L3dzGNRPOV2hcKMEpKztS1qDQhUhsm7Ntg7OU3kdC4moeC8/e45yrmrI62w
	BhXlpf7v3Ff8bZL20Rr6px1Wdh85OV6xFvGNLUtfuERF1f1H0r6YwozJin+rkDClKBMxm8
	3W7C+uerFGeDvruNZbIA3t6eIfzSuGE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-GdMf2a76Nyi15sWJVBcGiw-1; Tue, 14 Jan 2025 04:14:42 -0500
X-MC-Unique: GdMf2a76Nyi15sWJVBcGiw-1
X-Mimecast-MFC-AGG-ID: GdMf2a76Nyi15sWJVBcGiw
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b6ebe1ab63so1311368785a.1
        for <linux-nfs@vger.kernel.org>; Tue, 14 Jan 2025 01:14:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736846080; x=1737450880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dsbjO3iz2deQmMVjt427EZqTuNxVEkVFhRsvYx8eF1U=;
        b=UZqDW4qsAOhvXT80LkBtrleU3PnKewUcrzhQd3hO9m+JsbbPDcb9rC+u+1wCjqmNjq
         cH2BrfhAc8e/Dd/V8Iv055cmHiNMYtvuQV9XSvBQGuno+/lIXJVlKYeApe0CQ/Cu30RP
         eiaNkbRlg2YAFTTbjEf6m4okAF1XcSI17SwOrkHmBhi+44lV0Cr9DsOkuP6SG/Kww1n/
         vfrpCJ4izr/RODYwEty5n5OWp22v2FeN1qHqGQ+xRE8VtnyeBTs/w4m058DnGw0Dhy3R
         p2Ndh/1x7lVkmXFJtTzBc5lCscKZFP/YM3AudTp70JZm5UocpYBxY9SAw1T+VgtV9j6A
         1XJg==
X-Forwarded-Encrypted: i=1; AJvYcCU6QkxhuH9bUn4qwrf4TSej9L3D22U1VP2tEi7KSOQKfJocFSB3rhxqsFBe4a2dYgPLNA50v/RBpls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaMJKegS53a+klviwaNAeRh2l+S/cSrkZ9SASSHS3S6G7z/Ye2
	Srnr3hCO8Nv7VHGDyWOsUywilaKzQS0mngv8shpvaKFjwmEzhSXShe5UfL9i8ocCmZG8daIe/wz
	Wf4D1C4beh91/zzYcx56PKfOtYVIHD8JOX3IaWvyMgZujzWAc7Z6A13ejec6Kczw1NA==
X-Gm-Gg: ASbGncst6DoowGSQ+ROSQ7hNb83WnndWJH5AAgy7PdTVpNXq9bpOe1cLydcKOen0h6r
	103ssKn3Ro8K+mBiOWsXEx4amGMCaR2HhhT3VcFA4OE6IyLQYaQ1uxPJ4twH7HM8nIFVii9xiYb
	kwuEfLADjNWw6ArYdOQfVZ1BPfLKdZ7AzP34x0pniB3+4GZ58AkQ3psFfIvGLxy1xVsz/4Kzvjh
	ut0AahIBQtipQP+l18b357hJ6qKAWSTHBQCrde7cSAFhq//dxDkWz9q
X-Received: by 2002:a05:620a:4556:b0:7b6:dc74:82a8 with SMTP id af79cd13be357-7bcd9729af4mr3555543785a.9.1736846080138;
        Tue, 14 Jan 2025 01:14:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNQYAE8EwXo5bfz7d93WkTkkZQP0Ct36NcH8FG105SC5+s/0pcWIEJz4+Ax0uNVAvAbJhY6Q==
X-Received: by 2002:a05:620a:4556:b0:7b6:dc74:82a8 with SMTP id af79cd13be357-7bcd9729af4mr3555542285a.9.1736846079870;
        Tue, 14 Jan 2025 01:14:39 -0800 (PST)
Received: from [172.31.1.150] ([70.109.132.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3248900sm581829385a.34.2025.01.14.01.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 01:14:38 -0800 (PST)
Message-ID: <0312c8ae-a112-4920-8198-7296d8f741e4@redhat.com>
Date: Tue, 14 Jan 2025 04:14:37 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH NFS-UTILS 10/10] rpcctl: Add support for `rpcctl switch
 add-xprt`
To: Anna Schumaker <anna.schumaker@oracle.com>,
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
References: <20250108213726.260664-1-anna@kernel.org>
 <20250108213726.260664-11-anna@kernel.org>
 <2ac43d80-3623-4be6-8d3f-b2dffa485b12@redhat.com>
 <04515ed0-4b40-4dea-8cbd-29f05041464e@oracle.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <04515ed0-4b40-4dea-8cbd-29f05041464e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/13/25 11:29 AM, Anna Schumaker wrote:
> Hi Steve,
> 
> On 1/13/25 11:23 AM, Steve Dickson wrote:
>> Hey Anna,
>>
>> On 1/8/25 4:37 PM, Anna Schumaker wrote:
>>> From: Anna Schumaker <anna.schumaker@oracle.com>
>>>
>>> This is used to add an xprt to the switch at runtime.
>>>
>>> Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
>>> ---
>>>    tools/rpcctl/rpcctl.man |  4 ++++
>>>    tools/rpcctl/rpcctl.py  | 11 +++++++++++
>>>    2 files changed, 15 insertions(+)
>>>
>>> diff --git a/tools/rpcctl/rpcctl.man b/tools/rpcctl/rpcctl.man
>>> index b87ba0df41c0..2ee168c8f3c5 100644
>>> --- a/tools/rpcctl/rpcctl.man
>>> +++ b/tools/rpcctl/rpcctl.man
>>> @@ -12,6 +12,7 @@ rpcctl \- Displays SunRPC connection information
>>>    .BR "rpcctl client show " "\fR[ \fB\-h \f| \fB\-\-help \fR] [ \fIXPRT \fR]"
>>>    .P
>>>    .BR "rpcctl switch" " \fR[ \fB\-h \fR| \fB\-\-help \fR] { \fBset \fR| \fBshow \fR}"
>>> +.BR "rpcctl switch add-xprt" " \fR[ \fB\-h \fR| \fB\-\-help \fR] [ \fISWITCH \fR]"
>>>    .BR "rpcctl switch set" " \fR[ \fB\-h \fR| \fB\-\-help \fR] \fISWITCH \fBdstaddr \fINEWADDR"
>>>    .BR "rpcctl switch show" " \fR[ \fB\-h \fR| \fB\-\-help \fR] [ \fISWITCH \fR]"
>>>    .P
>>> @@ -29,6 +30,9 @@ Show detailed information about the RPC clients on this system.
>>>    If \fICLIENT \fRwas provided, then only show information about a single RPC client.
>>>    .P
>>>    .SS rpcctl switch \fR- \fBCommands operating on groups of transports
>>> +.IP "\fBadd-xprt \fISWITCH"
>>> +Add an aditional transport to the \fISWITCH\fR.
>>> +Note that the new transport will take its values from the "main" transport.
>>>    .IP "\fBset \fISWITCH \fBdstaddr \fINEWADDR"
>>>    Change the destination address of all transports in the \fISWITCH \fRto \fINEWADDR\fR.
>>>    \fINEWADDR \fRcan be an IP address, DNS name, or anything else resolvable by \fBgethostbyname\fR(3).
>>> diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
>>> index 20f90d6ca796..8722c259e909 100755
>>> --- a/tools/rpcctl/rpcctl.py
>>> +++ b/tools/rpcctl/rpcctl.py
>>> @@ -223,6 +223,12 @@ class XprtSwitch:
>>>            parser.set_defaults(func=XprtSwitch.show, switch=None)
>>>            subparser = parser.add_subparsers()
>>>    +        add = subparser.add_parser("add-xprt",
>>> +                                   help="Add an xprt to the switch")
>>> +        add.add_argument("switch", metavar="SWITCH", nargs=1,
>>> +                         help="Name of a specific xprt switch to modify")
>>> +        add.set_defaults(func=XprtSwitch.add_xprt)
>>> +
>>>            show = subparser.add_parser("show", help="Show xprt switches")
>>>            show.add_argument("switch", metavar="SWITCH", nargs='?',
>>>                              help="Name of a specific switch to show")
>>> @@ -246,6 +252,11 @@ class XprtSwitch:
>>>                return [XprtSwitch(xprt_switches / name)]
>>>            return [XprtSwitch(f) for f in sorted(xprt_switches.iterdir())]
>>>    +    def add_xprt(args):
>>> +        """Handle the `rpcctl switch add-xprt` command."""
>>> +        for switch in XprtSwitch.get_by_name(args.switch[0]):
>>> +            write_sysfs_file(switch.path / "xprt_switch_add_xprt", "1")
>>> +
>>>        def show(args):
>>>            """Handle the `rpcctl switch show` command."""
>>>            for switch in XprtSwitch.get_by_name(args.switch):
>>
>> Quick Question... Is this patch dependent on the previous
>> posted kernel patches (aka NFS & SUNRPC Sysfs Improvements)
> 
> Thanks for checking! Yes, these patches (especially the last two) are dependent on the kernel patches. I'm in the process of updating these for a v2 with the kernel stuff. If you would rather me split this up into cleanup patches and then new feature patches, I can definitely do that!
Please do! Thanks!!

steved.

> 
> Thanks,
> Anna
> 
>>
>> steved.
>>
> 


