Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE10398E3F
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jun 2021 17:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbhFBPUS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Jun 2021 11:20:18 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59614 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbhFBPUM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Jun 2021 11:20:12 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 220E322C9C;
        Wed,  2 Jun 2021 15:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622647108;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PCIZJLSBJCv2rvN4WuN+/UnNTgBZDhNIsMLBEbrkxYA=;
        b=nwpxIYZYopJ1KjEb832kWqIRzUFAxLXbvdKfZcNdSjhVWIjfvvlopDGc80GyyaknIN6ZvI
        on2DFAsyXGG3DoIseLiHXp610MctQ3hjDAXNVEEsTTNNLbk9b8QgRD9coQt9YtFa7GS5Hl
        39N3niKLJhCsPp+Aq04mDekMdg2kgL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622647108;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PCIZJLSBJCv2rvN4WuN+/UnNTgBZDhNIsMLBEbrkxYA=;
        b=8Rzd5Rtr7FTUkiN2nQMcJ1Bm8IZFGVVnWmeDSA5lwM3GF4xcr5EGApHkkDMo0N8bEX3TBS
        +oqATmKuDK5RnBDg==
Received: by imap.suse.de (Postfix, from userid 51)
        id 1A79911CDC; Wed,  2 Jun 2021 15:28:32 +0000 (UTC)
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 4E22711DBA;
        Wed,  2 Jun 2021 11:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622631856;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PCIZJLSBJCv2rvN4WuN+/UnNTgBZDhNIsMLBEbrkxYA=;
        b=Jj0FeTH4uMrfNPsRggxrXo/PBDgvhk9Ct5KNsrIGJOROGPl5TLhguY2s1dqdyGFFtdBuRt
        vIXU1T4j8R2l9o6gDdaYyz6VCq4pHXOlT+CTqbKUwbfqSlugtZ4fahPA46vITxp0evxuSJ
        wyajTepCQKRL3sBOq6ZL3heYPkhQmdA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622631856;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PCIZJLSBJCv2rvN4WuN+/UnNTgBZDhNIsMLBEbrkxYA=;
        b=DsY9+gV1nQdByp8DYLx67iJ8kj4zKscJVwXPs3XqeqZ/zS84bmnqSMXIAxN9pYZwF6RIaw
        C1usF7YLI5hm9DBA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 3WFfEbBlt2AnZAAALh3uQQ
        (envelope-from <pvorel@suse.cz>); Wed, 02 Jun 2021 11:04:16 +0000
Date:   Wed, 2 Jun 2021 13:04:14 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Cc:     ltp@lists.linux.it, linux-nfs@vger.kernel.org
Subject: Re: [LTP PATCH v2 3/3] nfs_lib.sh: Check running rpc.mountd,
 rpc.statd
Message-ID: <YLdlrnMj6FmyAWCV@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210526172503.18621-1-pvorel@suse.cz>
 <20210526172503.18621-3-pvorel@suse.cz>
 <02781c77-9fed-b111-c3ad-3043a6e0ca29@bell-sw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02781c77-9fed-b111-c3ad-3043a6e0ca29@bell-sw.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Alexey,

> > -TST_NEEDS_CMDS="$TST_NEEDS_CMDS mount exportfs"
> > +TST_NEEDS_CMDS="$TST_NEEDS_CMDS exportfs mount"

> Does it change anything?

Just sort alphabetically (not a problem here, but in longer list it's easier to
read).

> The rest looks good.
Thx!

Kind regards,
Petr
