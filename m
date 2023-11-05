Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C845B7E1421
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Nov 2023 16:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjKEPtG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 5 Nov 2023 10:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKEPtF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 5 Nov 2023 10:49:05 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5094EE0
        for <linux-nfs@vger.kernel.org>; Sun,  5 Nov 2023 07:49:02 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32d834ec222so1877596f8f.0
        for <linux-nfs@vger.kernel.org>; Sun, 05 Nov 2023 07:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google; t=1699199340; x=1699804140; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W/Noglwmh8HZnwgl9c8Q1g5hfablGxk/KsEmhTlqi8c=;
        b=Iri27MKjJd8jUML5UOInB8s69S6aKoRhbwye5055MeMoYsKuFRrUx+8hwGznoXAFnu
         G0BZYWZKTyUqRorluzI5QqxTb39MGfVmD/3YjT2uCQ0jfO/mmvw4U/rxfXg7gqz4bhWC
         eWXDZAwDFGlTU/9J16Th99uuHnzRou9NYXEKqTakWL274YhizCzYE6G3mBvOCpV6Ij4Z
         uBDvbkGI2h/vKXRjn2j/0CzveKFT6gw9KJBvFk1UBdcgq2YnLIV+X7qUiXhPcMm7/gcn
         Ea/8SkaiJUQfsz65tkGlvL9nkxku77IlaU8oJmao4fcA4QEubc/3+4dE34q7c9rh3R4I
         /Bag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699199340; x=1699804140;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W/Noglwmh8HZnwgl9c8Q1g5hfablGxk/KsEmhTlqi8c=;
        b=MMaWXMSbeD2HuA8aLXxHEc6GZzjQORn4VaGKEf6Dawh8wqZP68XMhTAJeuHkl2mFuh
         MpNMzmz/ZR7JDWU4OwS0ZZTkCzE0uepaEl9hgIC5FPcfdUy9epYPCRilpQYRbxSERGMo
         6LuvfY3WSwNvPJgcmzWtc/1w18alXmXWZ2gv3r3XJ4BL0OIFv+BxBxjDmb3JJRItJki9
         IC7KS268KCr+EOehfomOkpkbI8ThzkTEm3VCxmL0/wifMzV7crgV0v+iqXqLMsktn1Mt
         gbRyc0GN3C9/FTUceIbZe0Z88oUrUcTy8oBWztpoZuIV8BHokfI1wOVtGxayX4A5UNok
         uvTQ==
X-Gm-Message-State: AOJu0Yzoy5jYwm8nDw8gGCW8fPkusvawf1xoON4J50RvYiauhp6iu6Kq
        385bljBXquRJY+l3oh4NyQIhqQMuVvpQMGrg7iAQwxgE
X-Google-Smtp-Source: AGHT+IEbTq0NtWyo4t8sjmkxDv20OBlFwopir7lFne0Sm9L4DHzvUJVIR7d4KzMi+Bgivpl1U/asEA==
X-Received: by 2002:a5d:5381:0:b0:32d:a430:beb with SMTP id d1-20020a5d5381000000b0032da4300bebmr17236403wrv.39.1699199340330;
        Sun, 05 Nov 2023 07:49:00 -0800 (PST)
Received: from gmail.com ([2a0d:6fc2:6ab0:9500:b2fe:7351:edd7:6188])
        by smtp.gmail.com with ESMTPSA id f6-20020a5d5686000000b0032f7eaa6e43sm7088611wrv.79.2023.11.05.07.48.59
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 07:49:00 -0800 (PST)
Date:   Sun, 5 Nov 2023 17:48:57 +0200
From:   Dan Aloni <dan.aloni@vastdata.com>
To:     linux-nfs@vger.kernel.org
Subject: mount options not propagating to NFSACL and NSM RPC clients
Message-ID: <20231105154857.ryakhmgaptq3hb6b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

On Linux v6.6-14500-g1c41041124bd, I added a sysfs file for debugging
`/sys/kernel/debug/sunrpc/rpc_clnt/*/info`, and noticed that when
passing the following mount options: `soft,timeo=50,retrans=16,vers=3`,
NFSACL and NSM seem to take the defaults from somewhere else (xprt).
Specifically, locking operation behave as if in a hard mount with
these mount options.

Is it intentional?

    cl_prog: 100000
    cl_softrtry: 1
    cl_timeout: to_initval=10000, to_maxval=10000, to_increment=0, to_retries=2, to_exponential=0

    cl_prog: 100003
    cl_softrtry: 1
    cl_timeout: to_initval=5000, to_maxval=85000, to_increment=5000, to_retries=16, to_exponential=0

    cl_prog: 100000
    cl_softrtry: 1
    cl_timeout: to_initval=10000, to_maxval=10000, to_increment=0, to_retries=2, to_exponential=0

    cl_prog: 100021
    cl_softrtry: 0
    cl_timeout: to_initval=10000, to_maxval=60000, to_increment=10000, to_retries=5, to_exponential=0

    cl_prog: 100003
    cl_softrtry: 1
    cl_timeout: to_initval=5000, to_maxval=85000, to_increment=5000, to_retries=16, to_exponential=0

    cl_prog: 100227
    cl_softrtry: 1
    cl_timeout: to_initval=60000, to_maxval=60000, to_increment=0, to_retries=2, to_exponential=0
    

Also, here's the patch I used to expose this information:

-- >8 --
Subject: [PATCH] sunrpc: add per-client 'info' node in debugfs

---
 net/sunrpc/debugfs.c | 75 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/net/sunrpc/debugfs.c b/net/sunrpc/debugfs.c
index a176d5a0b0ee..61a2cc01815d 100644
--- a/net/sunrpc/debugfs.c
+++ b/net/sunrpc/debugfs.c
@@ -142,6 +142,77 @@ static int do_xprt_debugfs(struct rpc_clnt *clnt, struct rpc_xprt *xprt, void *n
 	return 0;
 }
 
+static int
+clnt_info_show(struct seq_file *seq, void *v)
+{
+	struct rpc_clnt *clnt = seq->private;
+	const struct rpc_timeout *timeout = clnt->cl_timeout;
+
+	seq_printf(seq, "cl_count: %d\n", refcount_read(&clnt->cl_count));
+	seq_printf(seq, "cl_pid: %d\n", atomic_read(&clnt->cl_pid));
+	seq_printf(seq, "cl_prog: %d\n", clnt->cl_prog);
+	seq_printf(seq, "cl_vers: %d\n", clnt->cl_vers);
+	seq_printf(seq, "cl_maxproc: %d\n", clnt->cl_maxproc);
+
+	seq_printf(seq, "cl_softrtry: %d\n", clnt->cl_softrtry);
+	seq_printf(seq, "cl_softerr: %d\n", clnt->cl_softerr);
+	seq_printf(seq, "cl_discrtry: %d\n", clnt->cl_discrtry);
+	seq_printf(seq, "cl_noretranstimeo: %d\n", clnt->cl_noretranstimeo);
+	seq_printf(seq, "cl_autobind: %d\n", clnt->cl_autobind);
+	seq_printf(seq, "cl_chatty: %d\n", clnt->cl_chatty);
+	seq_printf(seq, "cl_shutdown: %d\n", clnt->cl_shutdown);
+
+	seq_printf(seq, "cl_xprtsec: %d\n", clnt->cl_xprtsec.policy);
+	seq_printf(seq, "cl_rtt: timeo=%ld\n", clnt->cl_rtt->timeo);
+	seq_printf(seq, "cl_timeout: "
+		   "to_initval=%ld, to_maxval=%ld, to_increment=%ld, "
+		   "to_retries=%d, to_exponential=%d\n",
+		   timeout->to_initval, timeout->to_maxval,
+		   timeout->to_increment,
+		   timeout->to_retries, timeout->to_exponential);
+
+	seq_printf(seq, "cl_max_connect: %d\n", clnt->cl_max_connect);
+	seq_printf(seq, "cl_nodename: ");
+	seq_write(seq, clnt->cl_nodename, clnt->cl_nodelen);
+	seq_printf(seq, "\n");
+
+	return 0;
+}
+
+static int
+clnt_info_open(struct inode *inode, struct file *filp)
+{
+	int ret;
+	struct rpc_clnt *clnt = inode->i_private;
+
+	ret = single_open(filp, clnt_info_show, clnt);
+
+	if (!ret && !refcount_inc_not_zero(&clnt->cl_count)) {
+		single_release(inode, filp);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int
+clnt_info_release(struct inode *inode, struct file *filp)
+{
+	struct seq_file *seq = filp->private_data;
+	struct rpc_clnt *clnt = seq->private;
+
+	rpc_release_client(clnt);
+	return seq_release(inode, filp);
+}
+
+static const struct file_operations info_fops = {
+	.owner		= THIS_MODULE,
+	.open		= clnt_info_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= clnt_info_release,
+};
+
 void
 rpc_clnt_debugfs_register(struct rpc_clnt *clnt)
 {
@@ -160,6 +231,10 @@ rpc_clnt_debugfs_register(struct rpc_clnt *clnt)
 	debugfs_create_file("tasks", S_IFREG | 0400, clnt->cl_debugfs, clnt,
 			    &tasks_fops);
 
+	/* make info file */
+	debugfs_create_file("info", S_IFREG | 0400, clnt->cl_debugfs, clnt,
+			    &info_fops);
+
 	rpc_clnt_iterate_for_each_xprt(clnt, do_xprt_debugfs, &xprtnum);
 }
 
-- 
2.39.3


-- 
Dan Aloni
