Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020FE74EBB4
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jul 2023 12:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjGKK0B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jul 2023 06:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGKK0A (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jul 2023 06:26:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A27136
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jul 2023 03:25:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E796421ABB;
        Tue, 11 Jul 2023 10:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689071157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A5g3AMkv3gj43XScb00iliF2iHcS2w/aPbljO07aa6g=;
        b=jyw+d6z/t+lIp5oQiI/5a2LhXg0cP6yvfEljeZ7GR5THLISuOL0Zo84IvQDgbqKdvvnCBq
        UWD17uXrXvxc6P2M67qzJuoZIFX3Sp4Lb/qObXojlM0JWu6b9dhc+oywLzM46xykR95UnL
        C+z4DaD74AFlUcPKR4mMCubWo7hGL6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689071157;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A5g3AMkv3gj43XScb00iliF2iHcS2w/aPbljO07aa6g=;
        b=yXcERnAxpdyMZ4FKqV0rphuiD8F2JOF+HO68Ns+V2e5LP7BZauEnUvsHCxcIEX9TVi+opU
        ItJYdvUtTTFi8sDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B24701391C;
        Tue, 11 Jul 2023 10:25:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7nUJGTMurWTFeAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 11 Jul 2023 10:25:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@redhat.com>, "Chuck Lever" <cel@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        "Dave Chinner" <david@fromorbit.com>
Subject: Re: [PATCH/RFC] sunrpc: constant-time code to wake idle thread
In-reply-to: <B94C13E5-D84F-4BF7-A559-4E701B0AFA6D@oracle.com>
References: <168842897573.139194.15893960758088950748.stgit@manet.1015granger.net>,
 <168842927591.139194.16920372497489479670.stgit@manet.1015granger.net>,
 <168843152047.8939.5788535164524204707@noble.neil.brown.name>,
 <ZKN6GZ8q9NVLywOJ@manet.1015granger.net>,
 <168894969894.8939.6993305724636717703@noble.neil.brown.name>,
 <ZKwwFNeTw60Wuo+K@manet.1015granger.net>,
 <168902752676.8939.10101566412527206148@noble.neil.brown.name>,
 <a85a38468bf0af2f5cb38df2e1c20a8baa0bac6b.camel@redhat.com>,
 <B94C13E5-D84F-4BF7-A559-4E701B0AFA6D@oracle.com>
Date:   Tue, 11 Jul 2023 20:25:52 +1000
Message-id: <168907115231.8939.10978056514501244711@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 11 Jul 2023, Chuck Lever III wrote:
> 
> > On Jul 10, 2023, at 6:30 PM, Jeff Layton <jlayton@redhat.com> wrote:
> > 
> > On Tue, 2023-07-11 at 08:18 +1000, NeilBrown wrote:
> >> On Tue, 11 Jul 2023, Chuck Lever wrote:
> >>> 
> >>> Actually... Lorenzo reminded me that we need to retain a mechanism
> >>> that can iterate through all the threads in a pool. The xarray
> >>> replaces the "all_threads" list in this regard.
> >>> 
> >> 
> >> For what purpose?
> >> 
> > 
> > He's working on a project to add a rpc status procfile which shows in-
> > flight requests:
> > 
> >    https://bugzilla.linux-nfs.org/show_bug.cgi?id=366
> 
> Essentially, we want a lightweight mechanism for detecting
> unresponsive nfsd threads.
> 

Sounds reasonable - thanks.
Obviously the mechanism for that purpose can be completely separate from
any mechanism for finding idle threads.  And it can easily be re-added
if removed because all other uses disappear.

Thanks,
NeilBrown

