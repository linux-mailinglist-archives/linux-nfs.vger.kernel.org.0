Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08AB3CF0D1
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jul 2021 02:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235983AbhGSXwR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Jul 2021 19:52:17 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34946 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243971AbhGSXOe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Jul 2021 19:14:34 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9F78822238;
        Mon, 19 Jul 2021 23:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626738891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2e30UxNRYI81qzFHTtrwJ5lwISEqhM5uW8QAmbxdFV8=;
        b=T89awzIfzFFHwjP8S+ng7M6sirVcdMJI1lUO350U/K4A3V/Rvo1aUICYwZOK9hxSOAxGbR
        Yjh5F3bC5BwPWN7/YgcKNH55iEb8vRuAUCYv3Dr24/9u7iUiOd8LkcghFAgCpIpAG8q1YY
        UK7+rmUzk3bjyHjZ1SfvSTXQC8rgT80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626738891;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2e30UxNRYI81qzFHTtrwJ5lwISEqhM5uW8QAmbxdFV8=;
        b=Ea5DnS1JyVG2sIt78v1Ii+XDeLaV73dQWYRUXkBQLkdokH3lLP5DZu8V3OsI9r/23Aujr4
        Zl56hnPTW5quthBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3AD2A13D45;
        Mon, 19 Jul 2021 23:54:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mo+HN8cQ9mCOGgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 19 Jul 2021 23:54:47 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Christoph Hellwig" <hch@infradead.org>
Cc:     "Josef Bacik" <josef@toxicpanda.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>, linux-nfs@vger.kernel.org,
        "Wang Yugui" <wangyugui@e16-tech.com>,
        "Ulli Horlacher" <framstag@rus.uni-stuttgart.de>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH/RFC] NFSD: handle BTRFS subvolumes better.
In-reply-to: <YPVC/w4kw3y/14oF@infradead.org>
References: <20210613115313.BC59.409509F4@e16-tech.com>,
 <20210310074620.GA2158@tik.uni-stuttgart.de>,
 <162632387205.13764.6196748476850020429@noble.neil.brown.name>,
 <edd94b15-90df-c540-b9aa-8eac89b6713b@toxicpanda.com>,
 <YPBmGknHpFb06fnD@infradead.org>,
 <28bb883d-8d14-f11a-b37f-d8e71118f87f@toxicpanda.com>,
 <YPBvUfCNmv0ElBpo@infradead.org>,
 <e1d9caad-e4c7-09d4-b145-5397b24e1cc7@toxicpanda.com>,
 <YPVC/w4kw3y/14oF@infradead.org>
Date:   Tue, 20 Jul 2021 09:54:44 +1000
Message-id: <162673888433.4136.7451392112850411713@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 19 Jul 2021, Christoph Hellwig wrote:
> On Thu, Jul 15, 2021 at 02:01:11PM -0400, Josef Bacik wrote:
> > This is not a workable solution.  It's not a matter of simply tying into
> > existing infrastructure, we'd have to completely rework how the VFS deals
> > with this stuff in order to be reasonable.  And when I brought this up to=
 Al
> > he told me I was insane and we absolutely had to have a different SB for
> > every vfsmount, which means we can't use vfsmount for this, which means we
> > don't have any other options.  Thanks,
>=20
> Then fix the problem another way.  The problem is known, old and keeps
> breaking stuff.  Don't paper over it, fix it.=20

Do you have any pointers to other breakage caused by this particular
behaviour of btrfs? It would to have all requirements clearly on the
table while designing a solution.

Thanks,
NeilBrown
