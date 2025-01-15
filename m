Return-Path: <linux-nfs+bounces-9223-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F97CA1246D
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 14:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E23E93A5D25
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 13:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BBE2416B5;
	Wed, 15 Jan 2025 13:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fDCOAToq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3664F241A14
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 13:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736946459; cv=none; b=NUeUJJPE/MCVFzCu68iXfYoLinOM2jwGWOgxWH20E72RpzX2GEz38qop3jspczh98GrVJ9FXKKMCYnY3L4yrqBhPKFu+l9RwWgZlQZ1C4I0nYBcD0F8ml1OMu2yQQ0tO9F2s0Qc+LJs1SyhytOPkYmtJruBCtnFZpsdUggP/hrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736946459; c=relaxed/simple;
	bh=TYjT44Z1kYXDVjJD7Ylci5z/DcP6+X3cEhBNYfX4G5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=czajD2rP4+oFZKeNYkoWOccIjbdfv4W+Pb8Xyz11mMW0Qv8ijWVytiZu+joF008OAXVJpG4TR5XTARXycfUJ3aBG7apZAiCxRIe2E/HR+POkauVz4+4WSws+0myDCTdjcVoZwXKm0mQxkhxuR4TdtqS6f8AkddOuNgL7DoYR5os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fDCOAToq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736946456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KaOG/gBo/qUTxniqjrolFPVRpeegd8YgiAIGRDfdZdQ=;
	b=fDCOAToqRNx4JSpjo6EqRTfGJZw2TSMcraMXvdtooLNjWnhTQOcq1eubTkoCg/5QAXSxoB
	tjaOTC1LtFEImh0czTWW24k9tOSrBcQGCU/EwItb3netMwxGtyw8CJo0/VVTLb1ANi6CtM
	O7bsF7tkNTp1n5B+E3rIEY3X26iULWw=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-3uzJnRv4PI6zSvaL7XwHqg-1; Wed, 15 Jan 2025 08:07:34 -0500
X-MC-Unique: 3uzJnRv4PI6zSvaL7XwHqg-1
X-Mimecast-MFC-AGG-ID: 3uzJnRv4PI6zSvaL7XwHqg
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-216311faa51so15427745ad.0
        for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 05:07:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736946451; x=1737551251;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KaOG/gBo/qUTxniqjrolFPVRpeegd8YgiAIGRDfdZdQ=;
        b=sOOl4npFaOf5Hi4mnu1RRLj/ZjhE7Ov1COMscLlD1tThwfxynz9Jlz0DHT3+H0zxz+
         qsQQOiFgqWdv6keNEOCkNJtJxuCV04gzkx0E0J3ysGInHfPoxIotDkM8X2E9B56E3YCS
         3Nhd8abwiOxEW/rUwxxnOv1cKNTEh328K7dGG+tSZOwSi928AaElALhlElOZsjsnBDC2
         J1maR90EzAo19Rf69XNTNMYGeCKIpIPoe/+am/uHmWs2cTWwqXriCqZdjSVYw7T+3y6h
         0P12KelvIWCr2aigX440tlA/Mh11nySCC6MewRuasa3pocTBkGa8fmeI4frLUNajrmNH
         li3g==
X-Gm-Message-State: AOJu0YxqCbab0WUKElTYrhyoEuOAZgnOFkGEHW+4YP1O8mlxb8XxxYhX
	VsVP2FELjxXq1xlLG6JMJL9+Hg8UuLyD8e1R6p4RRrmDKKVjzWIqlcDE1/B0sbQ5/TNpydhb542
	+hQhXu3ioO5qAQgOLnhNQ+koi/2PP3EdZmjTK0Q/P8lHTvdDt0dSdInqPZcTozTswgw==
X-Gm-Gg: ASbGncsoOcl9MQr7Yk1GwuLXaGFEhtc+oiWk3vnQCIakyRaya3uSF/JKZWIBU7CBV1C
	dy3425m3b/BVZ5lsulYMIFsNGAYjdlqf2JiKRk9aGfLoiMCczTPnlg7JEzrlCd2EdbrbMCXSbIq
	oaSFybJPYALREVRqx4IVJohuhPsYK1hRQXsjZUs+ozNbmO2U/WJkSni3339TFqHqRya8o9TEoj2
	xlHeg4xqoNwEyvcjYr6lhttUjmp5qb5iWpiLoQLCE3m91YlEQQMOkrU
X-Received: by 2002:a17:903:2cc:b0:215:ae61:27ca with SMTP id d9443c01a7336-21bf0d33fdbmr38960255ad.26.1736946450909;
        Wed, 15 Jan 2025 05:07:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuLC0ePZDDLoOwWwD7QKZ03+WvGSi4d7QfZ0ZfdUlvMX4MwaDE4mnmNBMpKf6JTQpMdRp5Dw==
X-Received: by 2002:a17:903:2cc:b0:215:ae61:27ca with SMTP id d9443c01a7336-21bf0d33fdbmr38959925ad.26.1736946450542;
        Wed, 15 Jan 2025 05:07:30 -0800 (PST)
Received: from [172.31.1.150] ([70.109.132.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f21a62dsm81195515ad.126.2025.01.15.05.07.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 05:07:29 -0800 (PST)
Message-ID: <6f381b9a-555c-474f-8bfc-379500294edd@redhat.com>
Date: Wed, 15 Jan 2025 08:07:28 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH] nfsdctl: tweak the version subcommand behavior
To: Scott Mayhew <smayhew@redhat.com>
Cc: linux-nfs@vger.kernel.org
References: <20250108225439.814872-1-smayhew@redhat.com>
 <62c6a307-e17a-4c1a-a66f-1068bd4c2daf@redhat.com> <Z4ewl7SWj_O0LNtR@aion>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <Z4ewl7SWj_O0LNtR@aion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/15/25 7:56 AM, Scott Mayhew wrote:
> On Wed, 15 Jan 2025, Steve Dickson wrote:
> 
>>
>>
>> On 1/8/25 5:54 PM, Scott Mayhew wrote:
>>> The section for the 'nfsdctl version' subcommand on the man page states
>>> that the minorversion is optional, and if omitted it will cause all
>>> minorversions to be enabled/disabled, but it currently doesn't work that
>>> way.
>>>
>>> Make it work that way, with one exception.  If v4.0 is disabled, then
>>> 'nfsdctl version +4' will not re-enable it; instead it must be
>>> explicitly re-enabled via 'nfsdctl version +4.0'.  This mirrors the way
>>> /proc/fs/nfsd/versions works.
>>>
>>> Link: https://issues.redhat.com/browse/RHEL-72477
>>> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
>>> ---
>>>    utils/nfsdctl/nfsdctl.8    |  9 ++++--
>>>    utils/nfsdctl/nfsdctl.adoc |  5 +++-
>>>    utils/nfsdctl/nfsdctl.c    | 58 +++++++++++++++++++++++++++++++++++---
>>>    3 files changed, 64 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/utils/nfsdctl/nfsdctl.8 b/utils/nfsdctl/nfsdctl.8
>>> index b08fe803..835d60b4 100644
>>> --- a/utils/nfsdctl/nfsdctl.8
>>> +++ b/utils/nfsdctl/nfsdctl.8
>>> @@ -2,12 +2,12 @@
>>>    .\"     Title: nfsdctl
>>>    .\"    Author: Jeff Layton
>>>    .\" Generator: Asciidoctor 2.0.20
>>> -.\"      Date: 2024-12-30
>>> +.\"      Date: 2025-01-08
>>>    .\"    Manual: \ \&
>>>    .\"    Source: \ \&
>>>    .\"  Language: English
>>>    .\"
>>> -.TH "NFSDCTL" "8" "2024-12-30" "\ \&" "\ \&"
>>> +.TH "NFSDCTL" "8" "2025-01-08" "\ \&" "\ \&"
>>>    .ie \n(.g .ds Aq \(aq
>>>    .el       .ds Aq '
>>>    .ss \n[.ss] 0
>>> @@ -172,7 +172,10 @@ MINOR: the minor version integer value
>>>    .nf
>>>    .fam C
>>>    The minorversion field is optional. If not given, it will disable or enable
>>> -all minorversions for that major version.
>>> +all minorversions for that major version.  Note however that if NFSv4.0 was
>>> +previously disabled, it can only be re\-enabled by explicitly specifying the
>>> +minorversion (this mirrors the behavior of the /proc/fs/nfsd/versions
>>> +interface).
>>>    .fam
>>>    .fi
>>>    .if n .RE
>>> diff --git a/utils/nfsdctl/nfsdctl.adoc b/utils/nfsdctl/nfsdctl.adoc
>>> index c5921458..20e9bf8e 100644
>>> --- a/utils/nfsdctl/nfsdctl.adoc
>>> +++ b/utils/nfsdctl/nfsdctl.adoc
>>> @@ -91,7 +91,10 @@ Each subcommand can also accept its own set of options and arguments. The
>>>        MINOR: the minor version integer value
>>>      The minorversion field is optional. If not given, it will disable or enable
>>> -  all minorversions for that major version.
>>> +  all minorversions for that major version.  Note however that if NFSv4.0 was
>>> +  previously disabled, it can only be re-enabled by explicitly specifying the
>>> +  minorversion (this mirrors the behavior of the /proc/fs/nfsd/versions
>>> +  interface).
>>>      Note that versions can only be set when there are no nfsd threads running.
>>> diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
>>> index 722bf4a0..d86ff80e 100644
>>> --- a/utils/nfsdctl/nfsdctl.c
>>> +++ b/utils/nfsdctl/nfsdctl.c
>>> @@ -761,6 +761,32 @@ static int update_nfsd_version(int major, int minor, bool enabled)
>>>    	return -EINVAL;
>>>    }
>>> +static bool v40_is_disabled(void)
>>> +{
>>> +	int i;
>>> +
>>> +	for (i = 0; i < MAX_NFS_VERSIONS; ++i) {
>>> +		if (nfsd_versions[i].major == 0)
>>> +			break;
>>> +		if (nfsd_versions[i].major == 4 && nfsd_versions[i].minor == 0)
>>> +			return !nfsd_versions[i].enabled;
>>> +	}
>>> +	return false;
>>> +}
>>> +
>>> +static int get_max_minorversion(void)
>>> +{
>>> +	int i, max = 0;
>>> +
>>> +	for (i = 0; i < MAX_NFS_VERSIONS; ++i) {
>>> +		if (nfsd_versions[i].major == 0)
>>> +			break;
>>> +		if (nfsd_versions[i].major == 4 && nfsd_versions[i].minor > max)
>>> +			max = nfsd_versions[i].minor;
>>> +	}
>>> +	return max;
>>> +}
>>> +
>>>    static void version_usage(void)
>>>    {
>>>    	printf("Usage: %s version { {+,-}major.minor } ...\n", taskname);
>>> @@ -778,7 +804,8 @@ static void version_usage(void)
>>>    static int version_func(struct nl_sock *sock, int argc, char ** argv)
>>>    {
>>> -	int ret, i;
>>> +	int ret, i, j, max_minor;
>>> +	bool v40_disabled;
>>>    	/* help is only valid as first argument after command */
>>>    	if (argc > 1 &&
>>> @@ -792,6 +819,9 @@ static int version_func(struct nl_sock *sock, int argc, char ** argv)
>>>    		return ret;
>>>    	if (argc > 1) {
>>> +		v40_disabled = v40_is_disabled();
>>> +		max_minor = get_max_minorversion();
>>> +
>>>    		for (i = 1; i < argc; ++i) {
>>>    			int ret, major, minor = 0;
>>>    			char sign = '\0', *str = argv[i];
>>> @@ -815,9 +845,29 @@ static int version_func(struct nl_sock *sock, int argc, char ** argv)
>>>    				return -EINVAL;
>>>    			}
>>> -			ret = update_nfsd_version(major, minor, enabled);
>>> -			if (ret)
>>> -				return ret;
>>> +			/*
>>> +			 * The minorversion field is optional. If omitted, it should
>>> +			 * cause all the minor versions for that major version to be
>>> +			 * enabled/disabled.
>>> +			 *
>>> +			 * HOWEVER, we do not enable v4.0 in this manner if it was
>>> +			 * previously disabled - it has to be explicitly enabled
>>> +			 * instead.  This is to retain the behavior of the old
>>> +			 * /proc/fs/nfsd/versions interface.
>>> +			 */
>>> +			if (major == 4 && ret == 2) {
>>> +				for (j = 0; j <= max_minor; ++j) {
>>> +					if (j == 0 && enabled && v40_disabled)
>>> +						continue;
>>> +					ret = update_nfsd_version(major, j, enabled);
>>> +					if (ret)
>>> +						return ret;
>>> +				}
>>> +			} else {
>>> +				ret = update_nfsd_version(major, minor, enabled);
>>> +				if (ret)
>>> +					return ret;
>>> +			}
>>>    		}
>>>    		return set_nfsd_versions(sock);
>>>    	}
>> So nfsdctl version -4 turns of all v4 versions
>> and nfsdctl version +4 only turns on +4.1 +4.2.
>> nfsdctl version +4.0 is needed to turn on 4.0
>> leaving the rest of the minor versions on
>>
>> Is this intended?
> 
> No.  Jeff and I decided not to retain that behavior.  You should be
> looking at the v3 patchset at this point.
Got it... thanks!

steved.



