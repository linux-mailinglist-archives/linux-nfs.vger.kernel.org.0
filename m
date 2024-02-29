Return-Path: <linux-nfs+bounces-2121-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F36E586C718
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Feb 2024 11:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AADA1F2856C
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Feb 2024 10:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2720B79DA3;
	Thu, 29 Feb 2024 10:38:32 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A29464A93
	for <linux-nfs@vger.kernel.org>; Thu, 29 Feb 2024 10:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709203112; cv=none; b=JndXzV1CXV+jlq1P4XOU35hwny2ewcJPD0WtC+QAixQ4JLyGTVauHrxLXTfaYdL5dOExc0XQlEToqLUyj8Jh6xQSrj3wa2Tcoc8rbDNrEU0cnc6O0zewoDU3a2wQ2gyUeA5fUYYyoXCz366obIsruBj1IZQvKFUL7LmieUZxp2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709203112; c=relaxed/simple;
	bh=XcpYM6VefgLLRq54RpsBge41gCtxHaIDzjqWLqD0xBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cO3UiMLef3TiAeG96tfu/wU+VkGFCTICluGFUAb+xN/5wkVjwUrF0hBPRcZ5deoT8NIySRdPpNAEczDbnGpcNItbcjwzCWYHmYC8mVRjtiy4Pd4i46cuP2+Wo/VGJxuIvLcj8se7ZJRD6mQh82iYVOqKiIA+oi02QDICtVRbbgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1rfdnt-0004YL-Oj; Thu, 29 Feb 2024 11:38:17 +0100
Message-ID: <860e64ce-8f2e-4c07-a95c-18f72fb87216@pengutronix.de>
Date: Thu, 29 Feb 2024 11:38:16 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils] start-statd: use flock -x instead of -e for
 busybox compatibility
Content-Language: en-US
To: Calum Mackay <calum.mackay@oracle.com>, NeilBrown <neilb@suse.de>,
 Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org, kernel@pengutronix.de
References: <20240228185644.2743036-1-a.fatoum@pengutronix.de>
 <fd6db153-669f-4635-bacf-a23b0f7d2c7c@oracle.com>
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <fd6db153-669f-4635-bacf-a23b0f7d2c7c@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-nfs@vger.kernel.org

Hello Calum,

On 28.02.24 22:09, Calum Mackay wrote:
> On 28/02/2024 6:56 pm, Ahmad Fatoum wrote:
>> busybox flock(1) only supports -x and not -e. util-linux flock(1)
>> treats both -e and -x the same, documents them both in its man page,
>> but lists only -x in its help output.
>>
>> Referring to util-linux git, it seems both options were added between
>> util-linux-2.13-pre1 and util-linux-2.13-pre2 back in 2006, so there
>> should be no harm in switching over to flock -x to avoid confusing
>> error output when attempting to mount a NFS on a busybox system:
>>
>>    $ mount -t nfs 192.168.2.13:/home/afa/nfsroot/imx8mn-evk /mnt
>>    flock: invalid option -- 'e'
>>    BusyBox v1.36.0 () multi-call binary.
>>
>>    Usage: flock [-sxun] FD | { FILE [-c] PROG ARGS }
>>
>>    [Un]lock file descriptor, or lock FILE, run PROG
>>
>>            -s      Shared lock
>>            -x      Exclusive lock (default)
>>            -u      Unlock FD
>>            -n      Fail rather than wait
>>
>> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> 
> hi Ahmad,
> 
> Since the default is an exclusive lock, in both BusyBox and util-linux, might it be simpler just to run flock without that option?

That would be another possibility, yes. I don't mind the explicitness in
specifying an argument, but I don't feel strongly either way.

Cheers,
Ahmad

> 
> best wishes,
> calum.
> 
>> ---
>>   utils/statd/start-statd | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/utils/statd/start-statd b/utils/statd/start-statd
>> index b11a7d91a7f6..67a2f4ad8e0e 100755
>> --- a/utils/statd/start-statd
>> +++ b/utils/statd/start-statd
>> @@ -8,7 +8,7 @@ PATH="/sbin:/usr/sbin:/bin:/usr/bin"
>>     # Use flock to serialize the running of this script
>>   exec 9> /run/rpc.statd.lock
>> -flock -e 9
>> +flock -x 9
>>     if [ -s /run/rpc.statd.pid ] &&
>>          [ "1$(cat /run/rpc.statd.pid)" -gt 1 ] &&
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


