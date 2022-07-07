Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0783156974A
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Jul 2022 03:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiGGBNu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 21:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiGGBNt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 21:13:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1EC2C657
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 18:13:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8E94D1F977;
        Thu,  7 Jul 2022 01:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657156427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/iqy6VCoCoMWptFkWzgC0/+eopwnaC5f8jNdhsLJCUY=;
        b=z5r64qLTFLVjwFu22rq1yEiCi0g3FK1BsfxYnIV9/OXUtLhuicew9zdE/7W3BY6vjwMUn6
        azVICE3zp+7Z7rb7zuQvIkaYCOFhvCbqgCqcCD7/TD+1cXVMLwfBOqKuw8uw5NQCTjRP76
        9OR+FCOOE0+UVh9HUrTxWukZqNI6FKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657156427;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/iqy6VCoCoMWptFkWzgC0/+eopwnaC5f8jNdhsLJCUY=;
        b=fgSiEPAUeCEn1vvU8fzJWmD4FCkFyEMc1H4wZ6FqkDcf2uA8r8Qyp7Sdw972enwY6moDCk
        H/anHd6vHDY6cfDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6674113A7D;
        Thu,  7 Jul 2022 01:13:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3EPFCEozxmKPWwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 07 Jul 2022 01:13:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Problem with providing implementation id in NFSv4.1
Date:   Thu, 07 Jul 2022 11:13:43 +1000
Message-id: <165715642317.17141.14223480428236658557@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


In NFSv4.1 when we EXCHANGE_ID to talk to a new server - possibly a PNFS
Data Server that we haven't talked to before - we by default send an
implementation id.  This is created from several fields obtained from
utsname().
utsname() depends on current->nsproxy, and will crash if that is NULL.

When a process exits it calls, among other things,

	exit_task_namespaces(tsk);
	exit_task_work(tsk);

exit_task_namespaces() will set ->nsproxy to NULL
exit_task_work() will run delayed work items, including fput() on all
files that were still open when the process exited.  This will cause any
pending writes to be flushed for NFS.

So if a process writes to a file on a PNFS server, exits, and the MDS
tells the client to send the data to a DS which it hasn't established a
connection with before, then it will crash in encode_exchange_id().

That order of calls in do_exit() is deliberate so we cannot swap them - see
Commit: 8aac62706ada ("move exit_task_namespaces() outside of exit_notify()")

The options that I can see are:
1/ generate the implementation-id string at mount time and keep it
   around much like we do for cl_owner_id
2/ Check current->nsproxy in encode_exchange_id() and skip the
   implementation id if ->nsproxy is not available.
   Note that there is no risk for a race with testing ->nxproxy.

Doesn't anyone have a strong opinion of which is best.  I'm inclined to
go with '2', but mostly because it is less coding.

Thanks,
NeilBrown
