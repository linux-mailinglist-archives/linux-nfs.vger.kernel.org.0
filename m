Return-Path: <linux-nfs+bounces-5094-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 905EC93E0B2
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jul 2024 21:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 960851C20BD5
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jul 2024 19:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E22F28DB3;
	Sat, 27 Jul 2024 19:23:04 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5246C11C83
	for <linux-nfs@vger.kernel.org>; Sat, 27 Jul 2024 19:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722108184; cv=none; b=ejH6DCpwFmq3r7MG1di+h0tI9j1fxV50yGmkaTnz8ylekCtT7y2YC33dKCcynQX64OVkpIMLoGUJF1BKFdsPmgtY1KnBf9dcMukI3tY8v5D70P5VLX5TyE38NisREH3b1JptOMOKlnukBH+6UseTFv3hYzeaxbXZOwtg2eSK1Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722108184; c=relaxed/simple;
	bh=mlVXB8ElolTZh6kiNdy44Qi3qwF8KzbwGdtFp9C3xFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m55m38mV9Fb5VrVjuD5Mt4LzlOAkCliQpmuvhdukQ7sg0wqEjNYcmlJH6MjenXqOCX8fgxoncBAxnEGK3Xvhk6EQFRG2jSmqc49C7DzDQMHMn/bS1RXJvtN8iM3S+RnMsgV/CQm/L4Rx8YrPvpBXnlCeqgDL3Z4dyuH151/JCsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-36874fa319cso74083f8f.3
        for <linux-nfs@vger.kernel.org>; Sat, 27 Jul 2024 12:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722108180; x=1722712980;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N68zFdgWzpKXYjpkFjoZXwI64rhsqs7vbogxUKxHkWs=;
        b=sCRa0z/QxTWX4n2964nxsj30elwUOHI8IBGHK7uyuOdHbWgZd8yK8CwK9l78uebeq4
         nQF1k9LpSzK1SshiszT0O2DRVeuSWpd5R8UHcLjpAW5bWY//HyEm/qkpszvrk21qkUu4
         yH+GsuJxc5mxkRJgNLUL7Y5Qw7djb3utd9VPGdwyVxZvycWB37emtk4988cds31Pc3g6
         RNthw0sHLQWHgJgHR3mhIE3oaZuf0qzE5EI9NrvSO3k5FFgB+0MmBRmHN0cX2neqDROT
         uc/f7bYte37H6xok/63rkuZiJs9TYju2HdraSHqCh596wD57ZQYXcx1KKl8S1o8ec6Pg
         UXaA==
X-Forwarded-Encrypted: i=1; AJvYcCW+6XNZSc9EZdbDZyo3xJhh4bYADn7c/QyCtuVQq1PdHzwEE5iz7o5NgX6ak0VLMtiuLvuPVNODa5zRw3IPJVbRvu9n3xN7gQG/
X-Gm-Message-State: AOJu0YyetI+aYkHafjGfjYd4Edmwe0QU6cTX3YjVZyqq7Brw7bBdsdJY
	nN1n+Nhhdd4rciaJroD7E80Mmb0phPUQpnUv/V7wdgyIHNJrM58FlXsgTw==
X-Google-Smtp-Source: AGHT+IEshcQUHVfRMwgzB15RV6BaPv9Cra7AC6jNN7TwyvyXyTvAPqPJJwA8p9coZP5fMsspRERELw==
X-Received: by 2002:a05:600c:3b87:b0:426:5f08:542b with SMTP id 5b1f17b1804b1-428053c9c55mr42797605e9.0.1722108180139;
        Sat, 27 Jul 2024 12:23:00 -0700 (PDT)
Received: from [10.100.102.74] (89-138-69-172.bb.netvision.net.il. [89.138.69.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280f484cdesm58684565e9.44.2024.07.27.12.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jul 2024 12:22:59 -0700 (PDT)
Message-ID: <56399df2-ebe5-4d5c-9029-353424c52a7d@grimberg.me>
Date: Sat, 27 Jul 2024 22:22:58 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc 2/2] NFSD: allow client to use write delegation
 stateid for READ
To: Dai Ngo <dai.ngo@oracle.com>, Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
References: <20240724170138.1942307-1-sagi@grimberg.me>
 <20240724170138.1942307-2-sagi@grimberg.me>
 <ZqOtYYV2rQ7ROqXs@tissot.1015granger.net>
 <cc923db4-7ccf-47eb-af10-c77d7f50e5fd@oracle.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <cc923db4-7ccf-47eb-af10-c77d7f50e5fd@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> nfsd4_encode_read_plus() needs to handle write delegation stateids
>> as well.
>>
>> I'm not too sure about modifying the f_mode on an nfsd_file you
>> just got from a cache of shared nfsd_files.
>>
>> I think I'd prefer if preprocess_stateid returned an nfsd_file that
>> was already open for read.
>
> There would not be any nfsd_file that was already open for read since
> the file still has a write delegation on it, unless the open for read
> was from the same client.
>
> I'm also not sure if a client would send an open for read to the server
> when it already owned the write delegation of the file.

It doesn't have to, IIUC. So this needs to be addressed.
One thing that we could do is open the file for RW to begin with if we hand
out a write delegation?

BTW, the patch is missing the part that actually offers the write 
delegation,
which was sent initially.

