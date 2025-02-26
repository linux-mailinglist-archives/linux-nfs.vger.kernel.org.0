Return-Path: <linux-nfs+bounces-10355-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BBEA4544A
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Feb 2025 05:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB56B189377E
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Feb 2025 04:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE8020AF8E;
	Wed, 26 Feb 2025 04:09:25 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC724438B
	for <linux-nfs@vger.kernel.org>; Wed, 26 Feb 2025 04:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740542965; cv=none; b=GWf5z2iZ7ee4N0EBO56w69wbXrdiXCJUPAlaOMlMiCfm4JVurIC6PxY9ui6Rh+iWXYzz2xcAMej88fTwNAJY7FMu9CkKitiPROLUfNGLH+WklhH6CQhoTyEA0rBehZYDJIiL5wuVGP+mt61R9cZUFz8QdG+XMMs+jR5ECX65BqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740542965; c=relaxed/simple;
	bh=H6hGuE/ZNQtPl3OdNnrlxYt7WP9BsYjBlUYtio5peZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DVFl9cJOpcUZHtUM622z1T1Yk/yElAnOSnNyMTWp0MQtLs6x9Hfdax4UH+j1+3+6IVc8MkXiGHDon56mqzTgXngxB262KSbgZhuavnP259XYSFBgEBEIYdUFeM+nLzEl2FbA4yrwQvWl1mIdKJj9rsJRFW9QeKfnKBrwpnG5QzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Z2gtB3CBTzTkbH;
	Wed, 26 Feb 2025 12:07:46 +0800 (CST)
Received: from kwepemp200004.china.huawei.com (unknown [7.202.195.99])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F8AB14034E;
	Wed, 26 Feb 2025 12:09:18 +0800 (CST)
Received: from [10.174.179.184] (10.174.179.184) by
 kwepemp200004.china.huawei.com (7.202.195.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 26 Feb 2025 12:09:17 +0800
Message-ID: <8fce833f-0f86-4d02-b038-5b890991ba4d@huawei.com>
Date: Wed, 26 Feb 2025 12:09:16 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nfsdcld: fix cld pipe read size
To: Scott Mayhew <smayhew@redhat.com>
CC: <sorenson@redhat.com>, <s.ikarashi@fujitsu.com>, <jlayton@kernel.org>,
	<steved@redhat.com>, <linux-nfs@vger.kernel.org>
References: <07ba7ede-5127-4978-9195-26c3d04679c4@huawei.com>
 <cfa8c2a3-4e2d-45c8-a605-c66d92412d41@huawei.com>
 <277a7a65-0aea-496c-beb5-e4b6f6afc10e@huawei.com>
 <3e26c767-f347-4dbe-ae04-aabe8e87af12@huawei.com> <Z7210sTaCaamBGFR@aion>
From: "zhangjian (CG)" <zhangjian496@huawei.com>
In-Reply-To: <Z7210sTaCaamBGFR@aion>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemp200004.china.huawei.com (7.202.195.99)

on Tue, 25 Feb 2025,  Scott Mayhew wrote:
> On Tue, 25 Feb 2025, zhangjian (CG) wrote:
> 
>> Another thinking for that case: is it neccessory to write pipe with all possible xid to wake up all nfsd waiting for nfsdcld ? If nfsdcld is signaled SIGTERM in processing message, nfsdcld may also crash and nfsd wait for it forever too. 
> I'm not sure I understand.  Are you suggesting nfsdcld ignore signals in
> cld_gracestart()?
> 
> -Scott
Think of this case: cld_create has read message done and is killed
before writing downcall message, nfsdcld exits and this message will not
be read from pipe again by restarted nfsdcld. Nfsd will hung for nfsdcld
forever. If we can make a tool to write status=-EAGIN replay to all
possible upcalls, nfsd will put upcall message to pipe again and
restarted nfsdcld can read it again.

>>
>> On Tue, 25 Feb 2025, zhangjian (CG) wrote:
>>> When nfsd inits failed for detecting cld version in nfsd4_client_tracking_init, kernel may assume nfsdcld support version 1 message format and try to upcall with v1 message size to nfsdcld. There exists one error case in the following process, causeing nfsd hunging for nfsdcld replay: 
>>>
>>> kernel write to pipe->msgs (v1 msg length)     
>>>     |--------- first msg --------|-------- second message -------|
>>>
>>> nfsdcld read from pipe->msgs (v2 msg length)
>>>     |------------ first msg --------------|---second message-----|
>>>     |  valid message             | ignore |     wrong message    |
>>>
>>> When two nfsd kernel thread add two upcall messages to cld pipe with v1 version cld_msg (size == 1034) concurrently，but nfsdcld reads with v2 version size(size == 1067), 33 bytes of the second message will be read and merged with first message. The 33 bytes in second message will be ignored. Nfsdcld will then read 1001 bytes in second message, which cause FATAL in cld_messaged_size checking. Nfsd kernel thread will hang for it forever until nfs server restarts.
>>>
>>> Signed-off-by: zhangjian <zhangjian496@huawei.com>
>>> ---
>>>  utils/nfsdcld/nfsdcld.c | 63 ++++++++++++++++++++++++++++-------------
>>>  1 file changed, 43 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/utils/nfsdcld/nfsdcld.c b/utils/nfsdcld/nfsdcld.c
>>> index dbc7a57..76308d1 100644
>>> --- a/utils/nfsdcld/nfsdcld.c
>>> +++ b/utils/nfsdcld/nfsdcld.c
>>> @@ -716,35 +716,58 @@ reply:
>>>  	}
>>>  }
>>>
>>> +static int cld_pipe_read_msg(struct cld_client *clnt) {
>>> +	ssize_t len, left_len;
>>> +	ssize_t hdr_len = sizeof(struct cld_msg_hdr);
>>> +	struct cld_msg_hdr *hdr = (struct cld_msg_hdr *)&clnt->cl_u;;
>>> +
>>> +	len = atomicio(read, clnt->cl_fd, hdr, hdr_len);
>>> +
>>> +	if (len <= 0) {
>>> +		xlog(L_ERROR, "%s: pipe read failed: %m", __func__);
>>> +		goto fail_read;
>>> +	}
>>> +
>>> +	switch (hdr->cm_vers) {
>>> +	case 1:
>>> +		left_len = sizeof(struct cld_msg) - hdr_len;
>>> +		break;
>>> +	case 2:
>>> +		left_len = sizeof(struct cld_msg_v2) - hdr_len;
>>> +		break;
>>> +	default:
>>> +		xlog(L_ERROR, "%s: unsupported upcall version: %hu",
>>> +								__func__, hdr->cm_vers);
>>> +		goto fail_read;
>>> +	}
>>> +
>>> +	len = atomicio(read, clnt->cl_fd, hdr, left_len);
>>> +
>>> +	if (len <= 0) {
>>> +		xlog(L_ERROR, "%s: pipe read failed: %m", __func__);
>>> +		goto fail_read;
>>> +	}
>>> +
>>> +	return 0;
>>> +
>>> +fail_read:
>>> +	cld_pipe_open(clnt);
>>> +	return -1;
>>> +}
>>> +
>>>  static void
>>>  cldcb(int UNUSED(fd), short which, void *data)
>>>  {
>>> -	ssize_t len;
>>>  	struct cld_client *clnt = data;
>>> -#if UPCALL_VERSION >= 2
>>> -	struct cld_msg_v2 *cmsg = &clnt->cl_u.cl_msg_v2;
>>> -#else
>>> -	struct cld_msg *cmsg = &clnt->cl_u.cl_msg;
>>> -#endif
>>> +	struct cld_msg_hdr *hdr = (struct cld_msg_hdr *)&clnt->cl_u;
>>>
>>>  	if (which != EV_READ)
>>>  		goto out;
>>>
>>> -	len = atomicio(read, clnt->cl_fd, cmsg, sizeof(*cmsg));
>>> -	if (len <= 0) {
>>> -		xlog(L_ERROR, "%s: pipe read failed: %m", __func__);
>>> -		cld_pipe_open(clnt);
>>> +	if (cld_pipe_read_msg(clnt) < 0)
>>>  		goto out;
>>> -	}
>>> -
>>> -	if (cmsg->cm_vers > UPCALL_VERSION) {
>>> -		xlog(L_ERROR, "%s: unsupported upcall version: %hu",
>>> -				__func__, cmsg->cm_vers);
>>> -		cld_pipe_open(clnt);
>>> -		goto out;
>>> -	}
>>>
>>> -	switch(cmsg->cm_cmd) {
>>> +	switch (hdr->cm_cmd) {
>>>  	case Cld_Create:
>>>  		cld_create(clnt);
>>>  		break;
>>> @@ -765,7 +788,7 @@ cldcb(int UNUSED(fd), short which, void *data)
>>>  		break;
>>>  	default:
>>>  		xlog(L_WARNING, "%s: command %u is not yet implemented",
>>> -				__func__, cmsg->cm_cmd);
>>> +				__func__, hdr->cm_cmd);
>>>  		cld_not_implemented(clnt);
>>>  	}
>>>  out:
>>
> 
> 


