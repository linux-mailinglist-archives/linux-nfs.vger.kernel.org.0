Return-Path: <linux-nfs+bounces-9933-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2634A2C154
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 12:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62B6B161337
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 11:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D46E1DE8BC;
	Fri,  7 Feb 2025 11:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JN4HN32F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDDB1DC9B4
	for <linux-nfs@vger.kernel.org>; Fri,  7 Feb 2025 11:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738926498; cv=none; b=CXFfU29y124xFF3sNTkbUuTbzVhNm3yYml9GBdXOd+PKBN6tD3uBRJylZ2+UeP9XcmHL8S2wse55kEAN4qhqtxMOHitkL9G6rq2xvJQJRMJxPnjJtUI6RF8MeIsscePkSLksEjvEA/sOAoKAbGdsKAJRjIZDOhAlNxWtKq3IfyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738926498; c=relaxed/simple;
	bh=Sy0nIP4Uhx7FN8mClUVN9FheQVg5Ptid+djT1pEyZBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cDPY2RZ1HihzpuAD0WtjJ6wnmOVL0DzANgGU2ir8dYro0Xx2JzgoexWkX/HWP0iNeuj9Xi22em3Mqdl0Vs4a2Q5UQx/aoxn0FGYpEUEV4WF+RZRg8OgM5Yzqf+qWigjUxN4z0Bsjg74ZLFXu6ImeXNawZ5OLG513LLsfORO8hns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JN4HN32F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738926495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qGmlJ98r9sHl7WLM7lLFU5hV6M6KCo/67cfZ5wfl2LY=;
	b=JN4HN32FdEQhTniwP1+/Q/n//znvR4wKThsn/DZ1Y6njj8xEy93X7pRFUNB7XNOUeUZpPo
	3YtGopxufWGcHszWagFA/G2+4ul2df5TrA7IOoxYTTbrZMJlDO8L2goKdMnS2ufUip652v
	5T997exTiGzZWf0CA5E5kf6951FGkH0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-J2JSyDYlMlahxk_V_-hClg-1; Fri, 07 Feb 2025 06:08:14 -0500
X-MC-Unique: J2JSyDYlMlahxk_V_-hClg-1
X-Mimecast-MFC-AGG-ID: J2JSyDYlMlahxk_V_-hClg
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b6fe99d179so422541185a.2
        for <linux-nfs@vger.kernel.org>; Fri, 07 Feb 2025 03:08:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738926493; x=1739531293;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qGmlJ98r9sHl7WLM7lLFU5hV6M6KCo/67cfZ5wfl2LY=;
        b=P/P8rW6CAI8jQSt3gUVC9R13kNeFaou0/xesSqHafdgIaZrMIdP5UJaCv5XfcTtDCl
         VXzvgTWMIoW0sG1ji0H4tAKE4yYysFyAcrw76CBIxfSi90oWGb6czzY5gKmg0CS2r6FS
         yWreTMoVPYaazJCR6GH37Dz3ojqWjYub62WvCmMMLqkXiYZFGWXgS8L/nXrtO/uK5AnO
         QmHf81dfCOpSjF0yxK4/uPOk4Ddm27fWQVoM77WeOpPOD8wOpKUxXjs5REJFuD8Eoxej
         75KXOuPhaYFrL7OXCWYnD6yKDBApf1WPcL17M4bCIjcW1gPfovWQJt9DPzMu5hd9XHIe
         Pusw==
X-Forwarded-Encrypted: i=1; AJvYcCWKDge1Zq9q+GpogUHCvkDHBiRgBFQ8RkYWS+SKCLomt8kErYmXRFPdi/Ye4/A9AnUNfwH1RKbR2X4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV0KkYi+Yqk85k3wg1edzLrG+IpK9S57XH1hBVetBJArPE92FT
	5sF3s8mLfEOeArhcLIWprXdGK2J0AH5hfnXBls+dlbxFOslItKUx2j2xKkImLee4pYDngYTW8R6
	G4UuBwjc8FdEfx+tBi0BStxqbcPzQIOIAUthuMnaG9wzPZYhxa9f08iBQrjaDqMtVxA==
X-Gm-Gg: ASbGncvAkA3kGUxdVXzTO1R5PqD5QF3Nw4H4six+Yx7JLQdbV6MATPQ4xlMzV1lN8yY
	2TjuCpCXbg+fXQYPPDWlo42ASMSvAhhLOtP23tGk9xin7aCo6tZbTZr8mYhXwm/8n5oEMM/7GpX
	TcTwQ86hav6uGI4jR4084boJMW2I6N/1jz/vIkYo51V24gD0AWsz2c636xbCh+p0eCO1L6Ud92S
	iPR8YEmHArs88tAYEn1O9iszO1TkMTR1Vvk95XaOKk2OzsnkhcuX1pCHdhCCAJnKlZZ2NlIMmDu
	lH6BfQ==
X-Received: by 2002:a05:620a:43a1:b0:7bc:df55:2cd0 with SMTP id af79cd13be357-7c047c94970mr435995685a.48.1738926493281;
        Fri, 07 Feb 2025 03:08:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqYkzoEfZJo7YFSfksfhi2dqma8mQqQnY20Kv1hecxD0m+Tzk4KbrQTqIp8z1eaWY5AFiFkg==
X-Received: by 2002:a05:620a:43a1:b0:7bc:df55:2cd0 with SMTP id af79cd13be357-7c047c94970mr435992285a.48.1738926492839;
        Fri, 07 Feb 2025 03:08:12 -0800 (PST)
Received: from [172.31.1.150] ([70.105.251.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041e13863sm174166785a.60.2025.02.07.03.08.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 03:08:11 -0800 (PST)
Message-ID: <c22c8648-3d66-4c0e-9b0f-c1513044f02f@redhat.com>
Date: Fri, 7 Feb 2025 06:08:10 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils v2 4/4] rpcctl: Add support for `rpcctl switch
 add-xprt`
To: Anna Schumaker <anna.schumaker@oracle.com>,
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
References: <20250127215056.352658-1-anna@kernel.org>
 <20250127215056.352658-5-anna@kernel.org>
 <c6a022dc-b21e-45e6-ae17-b812a40ba038@redhat.com>
 <a8183611-e3d0-4a40-85f0-2d2b82088e71@oracle.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <a8183611-e3d0-4a40-85f0-2d2b82088e71@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hey Anna!

On 2/6/25 4:44 PM, Anna Schumaker wrote:
> Hi Steve,
> 
> On 2/5/25 5:23 PM, Steve Dickson wrote:
>>
>>
>> On 1/27/25 4:50 PM, Anna Schumaker wrote:
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
>>> index 130f245a64e8..29ae7d26f50e 100755
>>> --- a/tools/rpcctl/rpcctl.py
>>> +++ b/tools/rpcctl/rpcctl.py
>>> @@ -213,6 +213,12 @@ class XprtSwitch:
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
>>> @@ -236,6 +242,11 @@ class XprtSwitch:
>>>                return [XprtSwitch(xprt_switches / name)]
>>>            return [XprtSwitch(f) for f in sorted(xprt_switches.iterdir())]
>>>    +    def add_xprt(args):
>>> +        """Handle the `rpcctl switch add-xprt` command."""
>>> +        for switch in XprtSwitch.get_by_name(args.switch[0]):
>>> +            write_sysfs_file(switch.path / "add_xprt", "1")
>>> +
>>>        def show(args):
>>>            """Handle the `rpcctl switch show` command."""
>>>            for switch in XprtSwitch.get_by_name(args.switch):
>> Question... is this support needed by a kernel patch? if so is
>> it in a public kernel?
> 
> I'm about to post v3 of the patchset adding the kernel side of this. I'm hopeful it'll go in with the next merge window.
> 
So I'm assuming 'rpcctl switch add-xprt' will fail without the
kernel patch.

If that is the case... would it make sense to commit the first 3
patches and deal with this after kernel patch goes in?

steved.



