Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E774FA54D
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Apr 2022 08:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbiDIGKy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 9 Apr 2022 02:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbiDIGKx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 9 Apr 2022 02:10:53 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340EF4131C
        for <linux-nfs@vger.kernel.org>; Fri,  8 Apr 2022 23:08:46 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id g11so5383004qke.1
        for <linux-nfs@vger.kernel.org>; Fri, 08 Apr 2022 23:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=6aEcwmX5AHIuIeFqcYJ9jTFQjBEYXnOc4Olxo6nl8Es=;
        b=NqAdYhsFyqCpaZalKL8cZvkb0ebp2WuRLeZVDMBV9dnaLsD0hT6aMMQ1x2Gpg5345G
         +yO4oDYXUKqFAIV1Ac/DSJnN2zXSNk8YNat0v8IReqw/zVBgK8uPe1r4NjZWVWpybJU8
         dxf17wqIuahDlUYc1qEYdIrSo3YAZW/0uhEIvBdge44SZvyrjc/FGu+9F30AUhpazNQM
         UFO3izbcSbwR/kjPjgh+nyLiXzzlrRhudOVIhUrYpHG12yE+zu6lyoM90VBvW0GkHG6I
         ycykZh/XGWDW1qht46NE/BNnl/k2pgdvpjPmGyaU5zqIq52WH9JWnyILe48+6gOEaknW
         tGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=6aEcwmX5AHIuIeFqcYJ9jTFQjBEYXnOc4Olxo6nl8Es=;
        b=1zEkapgv79kbCOvIQpNEeJAdD5vPxOPJPENh+bDpuTzfHYhJ34ayXiQ4TD/0NWTvbP
         KHdF20AnHaLtvbZmQxdk+rYN4AHSR8cwsJagWtBfkdsEUXd+/cyI3bBeS9M9exk7gN1D
         CFUc8AFowezYREm6ciLs2wnx3Y6sF+S72Eyw3iz7r5yOKcEKQH9kUQvwgOicmXXgqVP7
         4PTbQSetuz65cdgiZ0AzPMzfiyKguL0xgvJmOsislLou3IdN9vM1UXV6ZvexOcnW4Ubm
         rjwTdRejNrsAutTvV5/0On3YC1q22S5jowzjlHx0/H4b4ipOVp2Uk0RmHNdtVYmsogSx
         xEfQ==
X-Gm-Message-State: AOAM5318fQgB5n3PHS3hYuwyVHUpAy2ieJ4SYl+ehWVGVLL5Bh+9OU6G
        uIEssw/1UdRzfJWP9BR/eec2Dg==
X-Google-Smtp-Source: ABdhPJwB4d7Ufi4cN4i+wikQ8L0VsgopVFCWZFF2+UtgD8fK4o0ibgOxwGW6k02yNhdIRgCp/83Ksg==
X-Received: by 2002:a05:620a:d87:b0:67b:311c:ecbd with SMTP id q7-20020a05620a0d8700b0067b311cecbdmr15327968qkl.146.1649484525161;
        Fri, 08 Apr 2022 23:08:45 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id p5-20020a378d05000000b0069beaffd5b3sm1849345qkd.4.2022.04.08.23.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 23:08:44 -0700 (PDT)
Date:   Fri, 8 Apr 2022 23:08:29 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Christoph Hellwig <hch@lst.de>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Mark Hemment <markhemm@googlemail.com>,
        Patrice CHOTARD <patrice.chotard@foss.st.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Borislav Petkov <bp@alien8.de>, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] tmpfs: fix regressions from wider use of ZERO_PAGE
In-Reply-To: <20220409050638.GB17755@lst.de>
Message-ID: <f73cfd56-35d2-53a3-3a59-4ff9495d7d34@google.com>
References: <9a978571-8648-e830-5735-1f4748ce2e30@google.com> <20220409050638.GB17755@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 9 Apr 2022, Christoph Hellwig wrote:
> On Fri, Apr 08, 2022 at 01:38:41PM -0700, Hugh Dickins wrote:
> > +		} else if (iter_is_iovec(to)) {
> > +			/*
> > +			 * Copy to user tends to be so well optimized, but
> > +			 * clear_user() not so much, that it is noticeably
> > +			 * faster to copy the zero page instead of clearing.
> > +			 */
> > +			ret = copy_page_to_iter(ZERO_PAGE(0), offset, nr, to);
> 
> Is the offset and length guaranteed to be less than PAGE_SIZE here?

Almost :) The offset is guaranteed to be less than PAGE_SIZE here, and
the length is guaranteed to be less than or equal to PAGE_SIZE - offset.

> 
> Either way I'd rather do this optimization in iov_iter_zero rather
> than hiding it in tmpfs.

Let's see what others say.  I think we would all prefer clear_user() to be
enhanced, and hack around it neither here in tmpfs nor in iov_iter_zero().
But that careful work won't get done by magic, nor by me.

And iov_iter_zero() has to deal with a wider range of possibilities,
when pulling in cache lines of ZERO_PAGE(0) will be less advantageous,
than in tmpfs doing a large dd - the case I'm aiming not to regress here
(tmpfs has been copying ZERO_PAGE(0) like this for years).

Hugh
