Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A460E3A7237
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Jun 2021 00:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbhFNWwq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Jun 2021 18:52:46 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33764 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhFNWwp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Jun 2021 18:52:45 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6933721995;
        Mon, 14 Jun 2021 22:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623711041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P4pTDeSF2y4uLXwHKaS8PMp4jCROv1FiN344ELVXeEk=;
        b=cujRGvD9RQW+gvPxcHckqEMU2SzYReDRQ5bnpcbC4FJmptM8Ni3RCeqIF92IxLrlvNpT9r
        wpplwaeZibHWg9BUx4fCSDQVaSTTV5sbct6MsnGyjcU9RVhrtUx6widgoGtAWzDo5y2Xjd
        8TWBtYKPiGhUMjT7njvz3GyNMhiZdvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623711041;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P4pTDeSF2y4uLXwHKaS8PMp4jCROv1FiN344ELVXeEk=;
        b=kxIep/0dO0ojfGWdAeow9CuJTYda7GMWw9lvFQrkHyEckRFwv1hzE6gN35rxmTg3hn0VPW
        v0ecqIlz1Wx4uHAg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 249C3118DD;
        Mon, 14 Jun 2021 22:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623711041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P4pTDeSF2y4uLXwHKaS8PMp4jCROv1FiN344ELVXeEk=;
        b=cujRGvD9RQW+gvPxcHckqEMU2SzYReDRQ5bnpcbC4FJmptM8Ni3RCeqIF92IxLrlvNpT9r
        wpplwaeZibHWg9BUx4fCSDQVaSTTV5sbct6MsnGyjcU9RVhrtUx6widgoGtAWzDo5y2Xjd
        8TWBtYKPiGhUMjT7njvz3GyNMhiZdvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623711041;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P4pTDeSF2y4uLXwHKaS8PMp4jCROv1FiN344ELVXeEk=;
        b=kxIep/0dO0ojfGWdAeow9CuJTYda7GMWw9lvFQrkHyEckRFwv1hzE6gN35rxmTg3hn0VPW
        v0ecqIlz1Wx4uHAg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id OtxhMT7dx2DGbwAALh3uQQ
        (envelope-from <neilb@suse.de>); Mon, 14 Jun 2021 22:50:38 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Wang Yugui" <wangyugui@e16-tech.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: any idea about auto export multiple btrfs snapshots?
In-reply-to: <20210613115313.BC59.409509F4@e16-tech.com>
References: <20210613115313.BC59.409509F4@e16-tech.com>
Date:   Tue, 15 Jun 2021 08:50:35 +1000
Message-id: <162371103543.23575.13662722966178222587@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, 13 Jun 2021, Wang Yugui wrote:
> Hi,
>=20
> Any idea about auto export multiple btrfs snapshots?
>=20
> One related patch is yet not merged to nfs-utils 2.5.3.
> From:   "NeilBrown" <neilb@suse.de>
> Subject: [PATCH/RFC v2 nfs-utils] Fix NFSv4 export of tmpfs filesystems.
>=20
> In this patch, an UUID is auto generated when a tmpfs have no UUID.
>=20
> for btrfs, multiple subvolume snapshot have the same filesystem UUID.
> Could we generate an UUID for btrfs subvol with 'filesystem UUID' + 'subvol=
 ID'?

You really need to ask this question of btrfs developers.  'mountd'
already has a special-case exception for btrfs, to prefer the uuid
provided by statfs64() rather than the uuid extracted from the block
device.  It would be quite easy to add another exception.
But it would only be reasonable to do that if the btrfs team told us how
that wanted us to generate a UUID for a given mount point, and promised
that would always provide a unique stable result.

This is completely separate from the tmpfs patch you identified.

NeilBrown


>=20
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2021/06/13
>=20
>=20
>=20
