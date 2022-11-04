Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9526619CC8
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Nov 2022 17:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiKDQOw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Nov 2022 12:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiKDQOt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Nov 2022 12:14:49 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0469B9C;
        Fri,  4 Nov 2022 09:14:48 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id v81so5651447oie.5;
        Fri, 04 Nov 2022 09:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vkBGgKFgg4QPXCpHtMi6j0J3ZcIgUdwyTJWClmiO8n8=;
        b=ZXT4b7xGHkwhtyRx7V1geQfUresoJ3Ad36AKxZcA+hYEkLlZTMmJdsg3FLF6RZb4Bm
         /Th2KOsiFM+wv4AFPnrljoJs2GpR7KNawydYt2C5cew9YFo+qW0UidzKrk4BDuG1u7w+
         m3w563eSaiPwL3l4sGKZaD+ak6hpgQhlR7eGCpJqdUtIM7CX7IVrS9HVCezWAA8wIfI4
         tbWxHgw8jm41jK3k3dRhGJKkPfEdX95COskXHfzG/e/VIoBDLovAFvOX7zEd4Utr1gQo
         7jv8BY+ymXeC+5KaWJgeXULPlc8QwCY2a+1Wc4m/cSjP0OKV+9XQ8V5888RvdMmc7n4q
         obpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vkBGgKFgg4QPXCpHtMi6j0J3ZcIgUdwyTJWClmiO8n8=;
        b=d8eBCYZinmkIS92p4B1dmXTy21acZvhKMOQ7ejoPvtcF8qtvkPPxJmi6VPwBt4EZhe
         XsrPPvZsO/KH+viUNwFr5Gj2ZkCyTLvBX/t1V9Z0WVI7F4Uwak/4kJCg4Bj6blyewcq2
         KTmaxQytYsyfDS9bQKMO5V3cUSeHLRy2DOrjz5+oU+YOkMjy1SU8wdbW8aOTv0dd5ZsW
         tuq7fDqirJeAkdSPGC1Tj8qSt0+2Bh1IrtZ0mTMRd4pvgdvvcNu5ns1pi5S0SLFkqA8/
         blDFVxMNv4aGQXpOpEM5wAHkwmYO2mkAV2voDDECHQFn6tXWjAzjgABjRbptPtyEyHwe
         gTuQ==
X-Gm-Message-State: ACrzQf3mtVO+xYSFFG0ZlR16/Z4nvI/TM1qoC4xZ6cTZfmu60g2gSJJe
        4PXn7gu2O4hEojPBUD4E0pY=
X-Google-Smtp-Source: AMsMyM7iFweEsB11T8MsAxnRkCeRKLOBdX0O0x9jUekHKEg87JfqIXfJu5mpVtFVdszEhc175Hq8Tw==
X-Received: by 2002:aca:d841:0:b0:35a:5959:590d with SMTP id p62-20020acad841000000b0035a5959590dmr2855416oig.120.1667578488108;
        Fri, 04 Nov 2022 09:14:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p36-20020a05687056a400b0013b1301ce42sm1894684oao.47.2022.11.04.09.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 09:14:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 4 Nov 2022 09:14:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mirko Lindner <mlindner@marvell.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Menglong Dong <imagedong@tencent.com>,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, lvs-devel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net
Subject: Re: [RFC][PATCH v2 19/31] timers: net: Use del_timer_shutdown()
 before freeing timer
Message-ID: <20221104161445.GA1866159@roeck-us.net>
References: <20221027163453.383bbf8e@gandalf.local.home>
 <CAHk-=whoS+krLU7JNe=hMp2VOcwdcCdTXhdV8qqKoViwzzJWfA@mail.gmail.com>
 <20221027170720.31497319@gandalf.local.home>
 <20221027183511.66b058c4@gandalf.local.home>
 <20221028183149.2882a29b@gandalf.local.home>
 <20221028154617.3c63ba68@kernel.org>
 <27a6a587fee5e9172e41acd16ae1bc1f556fdbd7.camel@redhat.com>
 <20221103175123.744d0f37@rorschach.local.home>
 <CANn89iLv9cak6_vXJG5t=Kq+eiMPdMxF8w4AAuAuFB5sOsy2zg@mail.gmail.com>
 <20221104015139.58f17730@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104015139.58f17730@rorschach.local.home>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Nov 04, 2022 at 01:51:39AM -0400, Steven Rostedt wrote:
> On Thu, 3 Nov 2022 17:00:20 -0700
> Eric Dumazet <edumazet@google.com> wrote:
> 
> >  inet_csk_clear_xmit_timers() can be called multiple times during TCP
> > socket lifetime.
> > 
> > (See tcp_disconnect(), which can be followed by another connect() ... and loop)
> > 
> > Maybe add a second parameter, or add a new
> > inet_csk_shutdown_xmit_timers() only called from tcp_v4_destroy_sock() ?
> > 
> 
> I guess.
> 
> > >
> > >  void inet_csk_delete_keepalive_timer(struct sock *sk)
> > >  {
> > > -       sk_stop_timer(sk, &sk->sk_timer);
> > > +       sk_shutdown_timer(sk, &sk->sk_timer);  
> > 
> > SO_KEEPALIVE can be called multiple times in a TCP socket lifetime,
> > on/off/on/off/...
> > 
> > I suggest leaving sk_stop_timer() here.
> > 
> > Eventually  inet_csk_clear_xmit_timers( sk, destroy=true) (or
> > inet_csk_shutdown_xmit_timers(())
> >    will  be called before the socket is destroyed.
> 
> OK. 
> 
> Guenter,
> 
> I posted a new series, but did not include this change. If you want to
> test that other series, I would suggest to at least add the first part
> of this patch, otherwise it will trigger. But we want to see if there's
> other locations of issue that we should care about.
> 

I'll run a test on the other series without change first. We'll see what
happens. If necessary I'll add [parts of] this patch and re-test, but
before doing that I would like to get a sense for the status of your
series as-is.

Thanks,
Guenter
