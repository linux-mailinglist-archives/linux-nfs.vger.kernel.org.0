Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA1A7D3CA2
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Oct 2023 18:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjJWQdO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Oct 2023 12:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbjJWQdO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Oct 2023 12:33:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7176E4;
        Mon, 23 Oct 2023 09:33:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3E01921883;
        Mon, 23 Oct 2023 16:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698078789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pkUZdvsSSaDISx+RdjKJSrvLwGsv/XeNdUS+HV1/3Ug=;
        b=qs0B9/vyx0wmHrmxIW/YeFn8p93gVPq8fBS0buXVxpqrL82Eq1BFJ8hEwckJMghMUaehgb
        aZdPwFfgOqs9EzPBnMak3Op85qWFFhdJfTene5pKDP2ao0NvaaAs/Uv5ZTpo8+j53CU36z
        GVkM+sLRl/Gdw9oNKtwKbAYq7T+8APA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698078789;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pkUZdvsSSaDISx+RdjKJSrvLwGsv/XeNdUS+HV1/3Ug=;
        b=a5q541TZqQ+U74KFYIJy2N1za4C8a8c78H8ItImld4bVulZVR9kIZHQrfcf8C12jy1PrKg
        bcKM9rBGw+Mg3uCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D377139C2;
        Mon, 23 Oct 2023 16:33:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iqP4CkWgNmXAMwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 23 Oct 2023 16:33:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id AFBDCA06B2; Mon, 23 Oct 2023 18:33:08 +0200 (CEST)
Date:   Mon, 23 Oct 2023 18:33:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 5/5] exportfs: support encoding non-decodeable file
 handles by default
Message-ID: <20231023163308.7szzloiuzzc7lnia@quack3>
References: <20231018100000.2453965-1-amir73il@gmail.com>
 <20231018100000.2453965-6-amir73il@gmail.com>
 <CAOQ4uxhiRU2nNnYtuXUaURMCuYjssC9Rn=ORWW=MmVyMD1H6Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhiRU2nNnYtuXUaURMCuYjssC9Rn=ORWW=MmVyMD1H6Rg@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -6.60
X-Spamd-Result: default: False [-6.60 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[7];
         FREEMAIL_TO(0.00)[gmail.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon 23-10-23 16:55:40, Amir Goldstein wrote:
> On Wed, Oct 18, 2023 at 1:00 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > AT_HANDLE_FID was added as an API for name_to_handle_at() that request
> > the encoding of a file id, which is not intended to be decoded.
> >
> > This file id is used by fanotify to describe objects in events.
> >
> > So far, overlayfs is the only filesystem that supports encoding
> > non-decodeable file ids, by providing export_operations with an
> > ->encode_fh() method and without a ->decode_fh() method.
> >
> > Add support for encoding non-decodeable file ids to all the filesystems
> > that do not provide export_operations, by encoding a file id of type
> > FILEID_INO64_GEN from { i_ino, i_generation }.
> >
> > A filesystem may that does not support NFS export, can opt-out of
> > encoding non-decodeable file ids for fanotify by defining an empty
> > export_operations struct (i.e. with a NULL ->encode_fh() method).
> >
> > This allows the use of fanotify events with file ids on filesystems
> > like 9p which do not support NFS export to bring fanotify in feature
> > parity with inotify on those filesystems.
> >
> > Note that fanotify also requires that the filesystems report a non-null
> > fsid.  Currently, many simple filesystems that have support for inotify
> > (e.g. debugfs, tracefs, sysfs) report a null fsid, so can still not be
> > used with fanotify in file id reporting mode.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> 
> Hi Jan,
> 
> Did you get a chance to look at this patch?
> I saw your review comments on the rest of the series, so was waiting
> for feedback on this last one before posting v2.

Ah, sorry. I don't have any further comments regarding this patch besides
what Chuck already wrote.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
