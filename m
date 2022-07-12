Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D134757147C
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Jul 2022 10:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbiGLI1y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Jul 2022 04:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiGLI1w (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Jul 2022 04:27:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7CF67A503
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 01:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657614470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JfQPW3k4yk+c+WSzuz95pilpy8J3eRh/AKdyQJaLcpA=;
        b=IVHYV0HvirnX3cGgBUU6tIcfKnobrfUJ2zMX5b61as/3EjDtCvkNM7zichhRAYX3fgUkF1
        rFv1j9E8KkTdE6AScm/wQ7eTpZISkqIsVVpxE5ct7TJeNRYslI0zbVrT0qLBo7vzfQTzJm
        7tvArIKqiP+W88AsYlojWRk76i2EnZM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-263-kwTzNT9sMWKa-78bk_kUnw-1; Tue, 12 Jul 2022 04:27:49 -0400
X-MC-Unique: kwTzNT9sMWKa-78bk_kUnw-1
Received: by mail-wr1-f70.google.com with SMTP id j23-20020adfb317000000b0021d7986c07eso1181326wrd.2
        for <linux-nfs@vger.kernel.org>; Tue, 12 Jul 2022 01:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JfQPW3k4yk+c+WSzuz95pilpy8J3eRh/AKdyQJaLcpA=;
        b=zq1Gj/lBeljeLrKbY9x/uzJdt3mdlDrR1Tfp/tFHqrnGN5BERSg2HSXkJ8+Zc1PgFC
         Dr9sZRYcWIaSlnkW5i/qO5LBngjPxnv/uIZ3O5tLahm68Vh+03rj5JddWMqlrsccDmhc
         Yq1D3RK+QK30dWoT64thOd3rM6QOPypOJuUdqYAcl5n0Z3nYS5m4q5VwwRo80xiHX86b
         7XaCxIk7LmsvMhNedaAylORDQlA2MaC3KaYvFHWRnq3s+h5nm0MJG3aNUxXJgWO1g53x
         QpZu1myGoTDz34Bpa8oveqoJc+bCYKIm0U03Wkgk3/1aiaEDLz2C9YN1j/wKOQuNRgn6
         DQ9w==
X-Gm-Message-State: AJIora9E+HYw0VhnTaIBOVXrK6tlBV1/MrilcuyXRGhRF6hgfq2YZTPs
        Wy+rqNJziSZfeegZFW+WGHvBMGIxECTCJIfNLpF6gLGgi+bnDxlJp1chGyoQhjdW6l4+i+oXiBx
        61G+hEsbMBfYnC/hx901F
X-Received: by 2002:a5d:47c7:0:b0:21d:ac9c:571c with SMTP id o7-20020a5d47c7000000b0021dac9c571cmr5343426wrc.522.1657614468421;
        Tue, 12 Jul 2022 01:27:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vgHRgKKemP017DzVbNknW+teMH9jsqa+xDB8nk5dZ4JSOVijFqOtntpmRtqeWasPBVM0vCiA==
X-Received: by 2002:a5d:47c7:0:b0:21d:ac9c:571c with SMTP id o7-20020a5d47c7000000b0021dac9c571cmr5343413wrc.522.1657614468244;
        Tue, 12 Jul 2022 01:27:48 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id bh21-20020a05600c3d1500b003a2d6c623f3sm12364159wmb.19.2022.07.12.01.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 01:27:47 -0700 (PDT)
Date:   Tue, 12 Jul 2022 10:27:46 +0200
From:   Igor Mammedov <imammedo@redhat.com>
To:     Bruce Fields <bfields@fieldses.org>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Ondrej Valousek <ondrej.valousek.xm@renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] nfsd changes for 5.18
Message-ID: <20220712102746.5404e88a@redhat.com>
In-Reply-To: <20220711181941.GC14184@fieldses.org>
References: <EF97E1F5-B70F-4F9F-AC6D-7B48336AE3E5@oracle.com>
        <20220710124344.36dfd857@redhat.com>
        <B62B3A57-A8F7-478B-BBAB-785D0C2EE51C@oracle.com>
        <5268baed1650b4cba32978ad32d14a5ef00539f2.camel@redhat.com>
        <20220711181941.GC14184@fieldses.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 11 Jul 2022 14:19:41 -0400
Bruce Fields <bfields@fieldses.org> wrote:

> On Mon, Jul 11, 2022 at 06:33:04AM -0400, Jeff Layton wrote:
> > On Sun, 2022-07-10 at 16:42 +0000, Chuck Lever III wrote:  
> > > > This patch regressed clients that support TIME_CREATE attribute.
> > > > Starting with this patch client might think that server supports
> > > > TIME_CREATE and start sending this attribute in its requests.  
> > > 
> > > Indeed, e377a3e698fb ("nfsd: Add support for the birth time
> > > attribute") does not include a change to nfsd4_decode_fattr4()
> > > that decodes the birth time attribute.
> > > 
> > > I don't immediately see another storage protocol stack in our
> > > kernel that supports a client setting the birth time, so NFSD
> > > might have to ignore the client-provided value.
> > >   
> > 
> > Cephfs allows this. My thinking at the time that I implemented it was
> > that it should be settable for backup purposes, but this was possibly a
> > mistake. On most filesystems, the btime seems to be equivalent to inode
> > creation time and is read-only.  
> 
> So supporting it as read-only seems reasonable.
> 
> Clearly, failing to decode the setattr attempt isn't the right way to do
> that.  I'm not sure what exactly it should be doing--some kind of
> permission error on any setattr containing TIME_CREATE?

erroring out on TIME_CREATE will break client that try to
set this attribute (legitimately). That's what by chance 
happening with current master (return error when TIME_CREATE
is present).

As long as server advertises support for TIME_CREATE
it should not error out when client sends it if spec permits
such use.

I think ignoring this attribute like Chuck has proposed
is acceptable (if one ignores archiving use case where
setting it makes sense).

Alternatively if folks inclined towards erroring out,
there should be a way to optout or optin from TIME_CREATE support,
to keep existing clients working + a sane error message so users
won't have to debug kernel to figure out what's wrong with
their setup.

> --b.
> 

