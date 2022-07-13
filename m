Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848135730E0
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Jul 2022 10:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbiGMIWI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Jul 2022 04:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235511AbiGMIVS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Jul 2022 04:21:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33396C050F
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 01:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657700279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uu20DLcBo8IMgtAmd4TXW8QAm+Rrq9nhKztBRSghNtQ=;
        b=byHTz0ITw1BM/tXoHEUWGldmkSHzEOjVrE+C0yk7vOfXE6nmWHHgr+45Nl+mE/ZNDM//7P
        iWRU68GVhk9wpwYW5LGMfqMSut5LS6Jvs+NgDG1s+MEpFBT48q5tZUg3meQnGrRyvkqK7I
        wy+SjFrZgRqzX5dQgpz3cKssA0KOxQA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-462-4O5fjAEiNXOb1o_wDi5MJg-1; Wed, 13 Jul 2022 04:17:58 -0400
X-MC-Unique: 4O5fjAEiNXOb1o_wDi5MJg-1
Received: by mail-ej1-f70.google.com with SMTP id hr24-20020a1709073f9800b0072b57c28438so2741557ejc.5
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 01:17:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uu20DLcBo8IMgtAmd4TXW8QAm+Rrq9nhKztBRSghNtQ=;
        b=fikmtEdAE5aSbCIPi75RfbRBE8eFEp3gBJrhJkyA9oG7lmCGte+aKkHm4JkYEqkYEb
         6prY/7QWZIOkB5E2mRD80O3hs+M+F1OmrIu0GR25w9FkAEmqYj6+0xbqYMOo97bbZav4
         8IUpY8V4TQ3V0GG5CsW7lhB+NVR5MW0qB7XUcwtorYLG9qwCUyz8gM2WqAsGj5KxOOQ4
         vPHe6UbOspb1Gy3azIXFLvFFG+7U515im5vgGZOGJgtIwqi9GV4YF2Fc3fnHal1pK1jG
         CCL3TZefTOndjzduo6ZmhGbpQzeqUiPURexdbvI3Fv7URYtavwpLANjKzWyhymYn0I1X
         621g==
X-Gm-Message-State: AJIora8ll8XwVDOkY+Q5FP7Pa1i8pURA8pA5OlaOhMhHanN2OJLZOFyZ
        +X0t5wUpKvr3sgJJw4EbjKYGlMwRet6vNl2hDa6X3i+/AQ+OGZzs0bvNajrkUc1CjFsQjwe6Q3d
        JjPpLrfxC47uDBUjQphWX
X-Received: by 2002:a05:6402:2743:b0:43a:7f92:8e30 with SMTP id z3-20020a056402274300b0043a7f928e30mr3058381edd.168.1657700276864;
        Wed, 13 Jul 2022 01:17:56 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vvDRpXirRM0iB6PQcdsyPrWgZ0lhMW3iiiISyYBlWepAh94KQ4/f62jliEYyvjsvyWAvo3wQ==
X-Received: by 2002:a05:6402:2743:b0:43a:7f92:8e30 with SMTP id z3-20020a056402274300b0043a7f928e30mr3058362edd.168.1657700276616;
        Wed, 13 Jul 2022 01:17:56 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ce14-20020a170906b24e00b0071cbc7487e0sm4684104ejb.71.2022.07.13.01.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 01:17:56 -0700 (PDT)
Date:   Wed, 13 Jul 2022 10:17:54 +0200
From:   Igor Mammedov <imammedo@redhat.com>
To:     Bruce Fields <bfields@fieldses.org>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Ondrej Valousek <ondrej.valousek.xm@renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] nfsd changes for 5.18
Message-ID: <20220713101754.50ad9bde@redhat.com>
In-Reply-To: <20220712114211.GA29976@fieldses.org>
References: <EF97E1F5-B70F-4F9F-AC6D-7B48336AE3E5@oracle.com>
        <20220710124344.36dfd857@redhat.com>
        <B62B3A57-A8F7-478B-BBAB-785D0C2EE51C@oracle.com>
        <5268baed1650b4cba32978ad32d14a5ef00539f2.camel@redhat.com>
        <20220711181941.GC14184@fieldses.org>
        <20220712102746.5404e88a@redhat.com>
        <20220712114211.GA29976@fieldses.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 12 Jul 2022 07:42:11 -0400
Bruce Fields <bfields@fieldses.org> wrote:

> On Tue, Jul 12, 2022 at 10:27:46AM +0200, Igor Mammedov wrote:
> > On Mon, 11 Jul 2022 14:19:41 -0400
> > Bruce Fields <bfields@fieldses.org> wrote:
> >   
> > > On Mon, Jul 11, 2022 at 06:33:04AM -0400, Jeff Layton wrote:  
> > > > On Sun, 2022-07-10 at 16:42 +0000, Chuck Lever III wrote:    
> > > > > > This patch regressed clients that support TIME_CREATE attribute.
> > > > > > Starting with this patch client might think that server supports
> > > > > > TIME_CREATE and start sending this attribute in its requests.    
> > > > > 
> > > > > Indeed, e377a3e698fb ("nfsd: Add support for the birth time
> > > > > attribute") does not include a change to nfsd4_decode_fattr4()
> > > > > that decodes the birth time attribute.
> > > > > 
> > > > > I don't immediately see another storage protocol stack in our
> > > > > kernel that supports a client setting the birth time, so NFSD
> > > > > might have to ignore the client-provided value.
> > > > >     
> > > > 
> > > > Cephfs allows this. My thinking at the time that I implemented it was
> > > > that it should be settable for backup purposes, but this was possibly a
> > > > mistake. On most filesystems, the btime seems to be equivalent to inode
> > > > creation time and is read-only.    
> > > 
> > > So supporting it as read-only seems reasonable.
> > > 
> > > Clearly, failing to decode the setattr attempt isn't the right way to do
> > > that.  I'm not sure what exactly it should be doing--some kind of
> > > permission error on any setattr containing TIME_CREATE?  
> > 
> > erroring out on TIME_CREATE will break client that try to
> > set this attribute (legitimately). That's what by chance 
> > happening with current master (return error when TIME_CREATE
> > is present).  
> 
> Hang on, now--our current server completely fails to decode any RPC
> including a SETATTR that attempts to set TIME_CREATE, which means it
> isn't able to return a useful error or tell the client which attribute
> was the problem.
> 
> It's not too surprising that that would cause a problem for a client.
> 
> But failures to set supported attributes are completely normal, and if
> mounts are failing completely because of that, something is really very
> wrong with the client.

returning unsupported attribute error might work, but as Chuck mentioned
we do kind of support TIME_CREATE for some requests so client might be
confused when server itself sends this attribute while errors out when
client tries to send it.
What I'm saying if we are to try returning error in this case
it should be tested with variety of clients before committing
to this approach. (meanwhile decoding and ignoring attribute
with Chuck's patch fixes immediate issue).

> Could you first retest with a server that's patched to at least decode
> the attribute correctly?  I suspect that may be enough.  If not, then
it does work with fixed decoding path:
 (i.e. patched with https://lore.kernel.org/lkml/A4F0C111-B2EB-4325-AC6A-4A80BD19DA43@oracle.com/T/)

> the client in question has a more interesting problem on its hands.
> 
> --b.
> 

