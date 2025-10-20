Return-Path: <linux-nfs+bounces-15396-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A7FBEF79C
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 08:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CEE4188D4F0
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 06:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFED2D8DB1;
	Mon, 20 Oct 2025 06:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iS3pzhTr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oWP6UlMh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j5uPdZ5d";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1l9JSvhu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F5B2D837B
	for <linux-nfs@vger.kernel.org>; Mon, 20 Oct 2025 06:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760941995; cv=none; b=C+FJnHqqQNnchHAYu9uY/N0gFG47ShJdxyjdLXlbNycGzbUe+DuOSq85rGPGO1TVJ6HXAycelokUC1RsOLsrZ39Zl0gnvYHE+c3QLbycqE8v45QkM4anqCGh5pktBhH3wQ2t12nbZ3cZPnfvjFIyp8rZL408H98Yb6LyZp5BemU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760941995; c=relaxed/simple;
	bh=T1C6KNrRX81hte0ENWczXE4+1vLDwuM65mCFX5Y3Gfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e95yD4vmiIy9KW6Hud+d1x6xjJnpLyCevOA3SN06C5xYAxqsTrR2AdnYmD/fB/az5IEHZhDGJ/x0KrlD65eeMbclXmmYyLpMSGSryLjAhMtfz9ZCNZeS7ucMsPO2PWoqJwmJnUqnU8MbNEoyMtWeFOjYqa48uTngodmIMWib8kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iS3pzhTr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oWP6UlMh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=j5uPdZ5d; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1l9JSvhu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 253CB21193;
	Mon, 20 Oct 2025 06:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760941986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p0JKnFlzd8UXhp4Y2ahcvueD8mr9lOiIzHpyyABEsqo=;
	b=iS3pzhTrUiYImuqKrSXLLUgPgcR53nvtlNUyX/6oF6NTbyv0nDmguIYJkh19VjO7XdXgoY
	OU8Dv/jWtnXfig7pUeuRbGS0eXjsAHQ9h8SSGpwG5wk+uhADbLprwNTA6fgeWL5raFudH8
	2XrwIlswRmdlMy4peWFsAZaT/vO+4dc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760941986;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p0JKnFlzd8UXhp4Y2ahcvueD8mr9lOiIzHpyyABEsqo=;
	b=oWP6UlMhOLLTbXktLmPNEErrzaNa+ZmUxZvEEa9MuRXt7tqvf3aaeSy8kdqvC082HqphkR
	svj25b6JCgk/21BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760941982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p0JKnFlzd8UXhp4Y2ahcvueD8mr9lOiIzHpyyABEsqo=;
	b=j5uPdZ5dR99iR8SZ2KHDneArjSvOf/3m1kNRCdC3xRJbRXkyzcrPmba2bnVMbIstLyFRYx
	cTrZH58MfyazQ2KZS91WLpqlvLb8FeNqASy09USTbuCoWF2rqRI+gic2GrZs2xw8MmNIK6
	0DCUImX9QMkEjoKYJRV0c5c/GL9qAGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760941982;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p0JKnFlzd8UXhp4Y2ahcvueD8mr9lOiIzHpyyABEsqo=;
	b=1l9JSvhuWBF4M6RNyqjohjr8IWZJ4MnU/PoweesWkkhqvQcnrRBy2t370oq1MQGT+7+4D7
	yJq/E4t1p6tpp7CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9193B13A8E;
	Mon, 20 Oct 2025 06:33:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Jp9EIZ3X9WgJXgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 20 Oct 2025 06:33:01 +0000
Message-ID: <8d6d76b4-6361-4392-9351-bd9d59c96ba0@suse.de>
Date: Mon, 20 Oct 2025 08:33:01 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] nvme-tcp: Allow userspace to trigger a KeyUpdate
 with debugfs
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
References: <20251017042312.1271322-1-alistair.francis@wdc.com>
 <20251017042312.1271322-7-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251017042312.1271322-7-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com,kernel.org,lists.linux.dev,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 10/17/25 06:23, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Allow userspace to trigger a KeyUpdate via debugfs. This patch exposes a
> key_update file that can be written to with the queue number to trigger
> a KeyUpdate on that queue.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v4:
>   - No change
> v3:
>   - New patch
> 
>   drivers/nvme/host/tcp.c | 72 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 72 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 791e0cc91ad8..f5c7b646d002 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -11,6 +11,7 @@
>   #include <linux/crc32.h>
>   #include <linux/nvme-tcp.h>
>   #include <linux/nvme-keyring.h>
> +#include <linux/debugfs.h>
>   #include <net/sock.h>
>   #include <net/tcp.h>
>   #include <net/tls.h>
> @@ -1429,6 +1430,75 @@ static void update_tls_keys(struct nvme_tcp_queue *queue)
>   	}
>   }
>   
> +#ifdef CONFIG_NVME_TCP_TLS
> +#define NVME_DEBUGFS_RW_ATTR(field) \
> +	static int field##_open(struct inode *inode, struct file *file) \
> +	{ return single_open(file, field##_show, inode->i_private); } \
> +	\
> +	static const struct file_operations field##_fops = { \
> +		.open = field##_open, \
> +		.read = seq_read, \
> +		.write = field##_write, \
> +		.release = single_release, \
> +	}
> +
> +static int nvme_ctrl_key_update_show(struct seq_file *m, void *p)
> +{
> +	seq_printf(m, "0\n");
> +
> +	return 0;
> +}
> +
> +static ssize_t nvme_ctrl_key_update_write(struct file *file, const char __user *buf,
> +					  size_t count, loff_t *ppos)
> +{
> +	struct seq_file *m = file->private_data;
> +	struct nvme_ctrl *nctrl = m->private;
> +	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
> +	char kbuf[16] = {0};
> +	int queue_nr, rc;
> +	struct nvme_tcp_queue *queue;
> +
> +	if (count > sizeof(kbuf) - 1)
> +		return -EINVAL;
> +	if (copy_from_user(kbuf, buf, count))
> +		return -EFAULT;
> +	kbuf[count] = 0;
> +
> +	rc = kstrtouint(kbuf, 10, &queue_nr);
> +	if (rc)
> +		return rc;
> +
> +	if (queue_nr >= nctrl->queue_count)
> +		return -EINVAL;
> +
> +	queue = &ctrl->queues[queue_nr];
> +
> +	update_tls_keys(queue);

Are you sure this is correct?

'update_tls_keys' is issuing a handshake request
with 'HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED'.

And the patch introducing it states:
At this time we don't support initiating a KeyUpdate.

So please move this to the patchset implementing support
for initiating KeyUpdates.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

