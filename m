Return-Path: <linux-nfs+bounces-1624-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E8B8442CA
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 16:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 379061C216F0
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 15:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F30B84A56;
	Wed, 31 Jan 2024 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TwAfBM2O";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dfmz3u5l";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TwAfBM2O";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dfmz3u5l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E9F84A26
	for <linux-nfs@vger.kernel.org>; Wed, 31 Jan 2024 15:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706714104; cv=none; b=ewDnXiMr93zA580p7Q1KWkYELYzEFA2ZDvVMwOqgldvtrcT+N580fD1SRdMQDfx7EtL0IMkI7Ewo+8yTrXVlXH78b/8hvCi+dWxK6LqTtgo2ngdPfwfU9aRQb7i+H78hqlxIcBNPI6WRAbsIyzMz73gymlCF5YckjrmJQQlKUYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706714104; c=relaxed/simple;
	bh=nUUYDsi06bemkleiSf2I+Gs7P7lbwWcbuQLzr5C9Ujc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kG5/+5s1I3Nd2rO5++oBs5kgfPCkEyj+5XnD2dgitzJV9FltEMppIbTVEUwswPjxJ4KBvG4xmQrZBoHSPAkIJjPH01JmGC6iGUMzeiFbW+DV+77l6hjjgy+nWT2plCna+/HBqv64M3VMHxx4ydeLs6g/hfWBIPBFKne2svW7NOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TwAfBM2O; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dfmz3u5l; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TwAfBM2O; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dfmz3u5l; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8970C1FB86;
	Wed, 31 Jan 2024 15:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706714100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ClPYoEK4bFUBa7k6SnD9lFD1SaV7eKmtVrefH6DHGA=;
	b=TwAfBM2OXILoTJennKq4re2ISrFXaBLrTrnm72b8S5/xwF0KMciraQ9urTo6FT0aPAGp0U
	gkhNWnYgnZh+EPjgcKbvR6+ADIflWW+yv+ZdY9nHPAtWMVhDsTVc7KshE7A+YRM3BMhFgP
	VF0QMcDjBOi6NqCk87+wSUPL4bLG27A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706714100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ClPYoEK4bFUBa7k6SnD9lFD1SaV7eKmtVrefH6DHGA=;
	b=dfmz3u5lraoKl4B9imW+Ktbtrb6LxHY+eCRRsVtjCDeeACqSShDyHpgmOXIqeBVSmuKQsW
	SneWzQrA1Co37WDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706714100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ClPYoEK4bFUBa7k6SnD9lFD1SaV7eKmtVrefH6DHGA=;
	b=TwAfBM2OXILoTJennKq4re2ISrFXaBLrTrnm72b8S5/xwF0KMciraQ9urTo6FT0aPAGp0U
	gkhNWnYgnZh+EPjgcKbvR6+ADIflWW+yv+ZdY9nHPAtWMVhDsTVc7KshE7A+YRM3BMhFgP
	VF0QMcDjBOi6NqCk87+wSUPL4bLG27A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706714100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ClPYoEK4bFUBa7k6SnD9lFD1SaV7eKmtVrefH6DHGA=;
	b=dfmz3u5lraoKl4B9imW+Ktbtrb6LxHY+eCRRsVtjCDeeACqSShDyHpgmOXIqeBVSmuKQsW
	SneWzQrA1Co37WDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3AD5B132FA;
	Wed, 31 Jan 2024 15:15:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id SEvuCvRjumWJeQAAn2gu4w
	(envelope-from <pvorel@suse.cz>); Wed, 31 Jan 2024 15:15:00 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Martin Doucha <mdoucha@suse.cz>,
	linux-nfs@vger.kernel.org,
	Cyril Hrubis <chrubis@suse.cz>
Subject: [PATCH 2/4] nfsstat01.sh: Validate parsing /proc/net/rpc/nfs{,d}
Date: Wed, 31 Jan 2024 16:14:44 +0100
Message-ID: <20240131151446.936281-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131151446.936281-1-pvorel@suse.cz>
References: <20240131151446.936281-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Score: 1.90
X-Spam-Flag: NO

print TWARN when parsing /proc/net/rpc/nfs{,d} fails.
NOTE: better would be to quit with TBROK, but at this point test would
fail to umount.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
NFS developers can ignore this patch (LTP specific).

@Cyril, @Martin it'd be nice to fix nfs_lib.sh so that it would support
tst_brk. The problem could be that get_calls() is called inside $()
therefore cd $LTPROOT (to leave mounted directory) in the cleanup
function is done for child process). I would have to redirect to a file
and read it afterwards, right? (similarly get_pcr10_aggregate() in
ima_tpm.sh does).

Kind regards,
Petr

 testcases/network/nfs/nfsstat01/nfsstat01.sh | 29 ++++++++++++++------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/testcases/network/nfs/nfsstat01/nfsstat01.sh b/testcases/network/nfs/nfsstat01/nfsstat01.sh
index 708750a97..4c09ae135 100755
--- a/testcases/network/nfs/nfsstat01/nfsstat01.sh
+++ b/testcases/network/nfs/nfsstat01/nfsstat01.sh
@@ -11,20 +11,33 @@ get_calls()
 	local name=$1
 	local field=$2
 	local nfs_f=$3
-	local calls=
-	local opt=
+	local type="lhost"
+	local calls opt
+
 	[ "$name" = "rpc" ] && opt="r" || opt="n"
+	! tst_net_use_netns && [ "$nfs_f" != "nfs" ] && type="rhost"
 
-	if tst_net_use_netns || [ "$nfs_f" = "nfs" ]; then
+	if [ "$type" = "lhost" ]; then
 		calls="$(grep $name /proc/net/rpc/$nfs_f | cut -d' ' -f$field)"
 		ROD nfsstat -c$opt | grep -q "$calls"
-		echo "$calls"
-		return
+	else
+		calls=$(tst_rhost_run -c "grep $name /proc/net/rpc/$nfs_f" | \
+			cut -d' ' -f$field)
+		tst_rhost_run -s -c "nfsstat -s$opt" | grep -q "$calls"
+	fi
+
+	if ! tst_is_int "$calls"; then
+		if [ "$type" = "lhost" ]; then
+			tst_res TINFO "lhost /proc/net/rpc/$nfs_f"
+			cat /proc/net/rpc/$nfs_f >&2
+		else
+			tst_res TINFO "rhost /proc/net/rpc/$nfs_f"
+			tst_rhost_run -c "cat /proc/net/rpc/$nfs_f" >&2
+		fi
+
+		tst_res TWARN "get_calls: failed to get integer value (args: $@)"
 	fi
 
-	calls=$(tst_rhost_run -c "grep $name /proc/net/rpc/$nfs_f" | \
-		cut -d' ' -f$field)
-	tst_rhost_run -s -c "nfsstat -s$opt" | grep -q "$calls"
 	echo "$calls"
 }
 
-- 
2.43.0


