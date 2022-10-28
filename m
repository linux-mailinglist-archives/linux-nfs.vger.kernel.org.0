Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FAB6115A8
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 17:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiJ1PQy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 11:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiJ1PQc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 11:16:32 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07AF209FBE;
        Fri, 28 Oct 2022 08:16:31 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id r187so6433063oia.8;
        Fri, 28 Oct 2022 08:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+dn3LvliggqMwu/IM8leC7rc7cJb8gzlcVAfQFIHk4A=;
        b=h1quau0gp/0GF4+bcmlKCzuKxivWRlPioezIkKjWkC8nElVhrOfUCr7ucyKuhfk6WE
         HTsqjpSaeLVTZZapEdzrMPciuXJu4uHQdhiaqY+5OLds249yg06F4sxMJ0OOy5CTZTEG
         1rzXzHCxAaesLgoD16vX8bgYoSsuF6vq2zy7p/XJLFPUT98Ippf4US0Qxf8CvgydU5aZ
         lbdUx2TtTmrI7GSONljaq3U2QH4THWpE2ZwljGtMuaEGdSGlFSj09K3XiXQppa7JglZ7
         vziqn1tVJFMgeXyOduiKTsiByBdfPGqF+p+AerBxXmi9Gt1VBL3YUhBBR/6OqX2ezkTR
         Wsgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+dn3LvliggqMwu/IM8leC7rc7cJb8gzlcVAfQFIHk4A=;
        b=IcEAAvyWEQ8zLNuounegCMuRQYsqC9gUZnlTP8yNAtg+PE31svqsz7pAQPH1RgW1SO
         43gJorQAgcFK7sHOFtNHr4KrEcFWokcnC7frwbkERtyunmt17NPM1h4MMQ6/qiSVBxhl
         odcHW5qHYjGzoZQd99wNgToTOpJB8jVyfHpRdz32LI5so217i7oJnFhjZvu9ZmhGbzRF
         gG9G1N4GgNufVQuGkEUShTK7rsi8rMZWrCviCQjld7bPA1xF0NUcatE5VOkgmqNBoVT0
         6mWOkP1fCLjvm5eTemJfXqQNAn0sKvBKSufecE5pqb/bDL7X1ZbhLwgzyQH8vLgNQ0wu
         dSwg==
X-Gm-Message-State: ACrzQf1OVh8cbLyRPxKskGPlB0wNhAdvbnx33IzAVRvEuhCUzEgRbOu6
        2zfSayCKILhM7dhX2gh4rn0=
X-Google-Smtp-Source: AMsMyM5cwAs/ShR6qmIwoZgvBqbKWpziGl3MqG4MeW+pmPBZ2NNmgpvYAkZaU5rvq3DgN3FmYZ43+A==
X-Received: by 2002:a05:6808:308c:b0:354:99ec:bbb7 with SMTP id bl12-20020a056808308c00b0035499ecbbb7mr48262oib.68.1666970191098;
        Fri, 28 Oct 2022 08:16:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 125-20020a4a1483000000b0047f8ceca22bsm1655725ood.15.2022.10.28.08.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 08:16:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d8185ff7-d1a2-0d74-30d0-03392e630280@roeck-us.net>
Date:   Fri, 28 Oct 2022 08:16:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC][PATCH v2 19/31] timers: net: Use del_timer_shutdown()
 before freeing timer
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
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
References: <20221027150525.753064657@goodmis.org>
 <20221027150928.780676863@goodmis.org>
 <20221027155513.60b211e2@gandalf.local.home>
 <CAHk-=wjAjW2P5To82+CAM0Rx8RexQBHPTVZBWBPHyEPGm37oFA@mail.gmail.com>
 <20221027163453.383bbf8e@gandalf.local.home>
 <20221027170755.40ee4059@gandalf.local.home>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20221027170755.40ee4059@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 10/27/22 14:07, Steven Rostedt wrote:
> On Thu, 27 Oct 2022 16:34:53 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> What about del_timer_try_shutdown(), that if it removes the timer, it sets
>> the function to NULL (making it equivalent to a successful shutdown),
>> otherwise it does nothing. Allowing the the timer to be rearmed.
>>
>> I think this would work in this case.
> 
> Guenter,
> 
> Can you apply this patch on top of the series, and see if it makes the
> warning go away?
> 

That patch not only helps, it also fixes the crash seen with openrisc.
For that crash, I was able to collect some useful data; see the log below.

Thanks,
Guenter

---
WARNING: CPU: 0 PID: 7 at lib/debugobjects.c:502 debug_print_object+0xc0/0xe8
ODEBUG: free active (active state 0) object type: timer_list hint: rcu_lock_map+0x0/0x14
Modules linked in:
CPU: 0 PID: 7 Comm: ksoftirqd/0 Not tainted 6.1.0-rc2-00145-g2c4e85e9ac93 #1
Call trace:
[<048ecc8e>] dump_stack_lvl+0x44/0x80
[<c6a7029c>] dump_stack+0x1c/0x2c
[<b225e4eb>] __warn+0xdc/0x118
[<1070b766>] ? debug_print_object+0xc0/0xe8
[<57923a76>] warn_slowpath_fmt+0x78/0x90
[<1070b766>] debug_print_object+0xc0/0xe8
[<b3abbcb0>] __debug_check_no_obj_freed+0x230/0x2b8
[<508d9b5a>] ? delayed_put_task_struct+0x0/0x84
[<30f5a2a0>] ? _s_kernel_ro+0x0/0x200
[<403ab082>] debug_check_no_obj_freed+0x30/0x40
[<82702c56>] free_pcp_prepare+0xc4/0x2b0
[<508d9b5a>] ? delayed_put_task_struct+0x0/0x84
[<7798b190>] free_unref_page+0x44/0x210
[<d73717e5>] __free_pages+0x108/0x124
[<a32de4eb>] slob_free_pages+0x9c/0xac
[<bd51c171>] slob_free+0x40c/0x62c
[<a2d26e0e>] ? thread_stack_free_rcu+0x0/0x44
[<24b2df6c>] ? rcu_process_callbacks+0x114/0x224
[<24b2df6c>] ? rcu_process_callbacks+0x114/0x224
[<7794ec75>] ? rcu_process_callbacks+0xdc/0x224
[<7794ec75>] ? rcu_process_callbacks+0xdc/0x224
[<d76fe88f>] kmem_cache_free+0x64/0xa0
[<46d25dac>] free_task+0x7c/0xe0
[<2df25813>] __put_task_struct+0xe8/0x194
[<64f9675b>] delayed_put_task_struct+0x58/0x84
[<8755437e>] rcu_process_callbacks+0xf0/0x224
[<24b2df6c>] ? rcu_process_callbacks+0x114/0x224
[<020db442>] ? rcu_process_callbacks+0x178/0x224
[<87626af4>] __do_softirq+0x11c/0x2f8
[<c3f89a50>] ? smpboot_thread_fn+0x4c/0x304
[<c3f89a50>] ? smpboot_thread_fn+0x4c/0x304
[<021b0175>] ? smpboot_thread_fn+0x188/0x304
[<f2e79ebd>] ? smpboot_thread_fn+0x158/0x304
[<966be0e6>] run_ksoftirqd+0x4c/0x80
[<4bf65f60>] smpboot_thread_fn+0x180/0x304
[<3f914d93>] ? _raw_spin_unlock_irqrestore+0x50/0x84
[<bef37779>] ? __kthread_parkme+0x60/0xdc
[<b0798e10>] ? smpboot_thread_fn+0x0/0x304
[<c463cd92>] kthread+0x11c/0x144
[<3eaef0b7>] ? kthread+0x0/0x144
[<ef2f6228>] ret_from_fork+0x1c/0x84
---[ end trace 0000000000000000 ]---
Unable to handle kernel access
  at virtual address 0xbd6ed6a4

Oops#: 0000
CPU #: 0
    PC: c0056c78    SR: 00008679    SP: c1027c24
GPR00: 00000000 GPR01: c1027c24 GPR02: c1027c78 GPR03: 00008279
GPR04: 00000000 GPR05: 00000000 GPR06: 00000000 GPR07: 00000001
GPR08: 00000000 GPR09: c0056c64 GPR10: c1026000 GPR11: 00000000
GPR12: 00000000 GPR13: 00000001 GPR14: c05c0000 GPR15: 00000000
GPR16: 00000001 GPR17: bd6ed6a4 GPR18: ff4517b0 GPR19: fd145f00
GPR20: 00000000 GPR21: 00000000 GPR22: 00000000 GPR23: c0760000
GPR24: c10232a0 GPR25: 00000003 GPR26: 00000000 GPR27: 00000000
GPR28: c1a00458 GPR29: 00000000 GPR30: c0790000 GPR31: 00000000
   RES: 00000000 oGPR11: ffffffff
Process ksoftirqd/0 (pid: 7, stackpage=c10232a0)

Stack:
Call trace:
[<6ce5cfad>] __lock_acquire.constprop.0+0xa8/0x914
[<4bc14e12>] ? __del_timer_sync+0x0/0x128
[<da915c87>] lock_acquire.part.0.isra.0+0xd4/0x1ac
[<4bc14e12>] ? __del_timer_sync+0x0/0x128
[<9b341df3>] lock_acquire+0x2c/0x44
[<233b5cbc>] __del_timer_sync+0x64/0x128
[<4bc14e12>] ? __del_timer_sync+0x0/0x128
[<05cd2741>] timer_fixup_free+0x34/0x5c
[<3fa496ad>] __debug_check_no_obj_freed+0x250/0x2b8
[<508d9b5a>] ? delayed_put_task_struct+0x0/0x84
[<30f5a2a0>] ? _s_kernel_ro+0x0/0x200
[<403ab082>] debug_check_no_obj_freed+0x30/0x40
[<82702c56>] free_pcp_prepare+0xc4/0x2b0
[<508d9b5a>] ? delayed_put_task_struct+0x0/0x84
[<7798b190>] free_unref_page+0x44/0x210
[<d73717e5>] __free_pages+0x108/0x124
[<a32de4eb>] slob_free_pages+0x9c/0xac
[<bd51c171>] slob_free+0x40c/0x62c
[<a2d26e0e>] ? thread_stack_free_rcu+0x0/0x44
[<24b2df6c>] ? rcu_process_callbacks+0x114/0x224
[<24b2df6c>] ? rcu_process_callbacks+0x114/0x224
[<7794ec75>] ? rcu_process_callbacks+0xdc/0x224
[<7794ec75>] ? rcu_process_callbacks+0xdc/0x224
[<d76fe88f>] kmem_cache_free+0x64/0xa0
[<46d25dac>] free_task+0x7c/0xe0
[<2df25813>] __put_task_struct+0xe8/0x194
[<64f9675b>] delayed_put_task_struct+0x58/0x84
[<8755437e>] rcu_process_callbacks+0xf0/0x224
[<24b2df6c>] ? rcu_process_callbacks+0x114/0x224
[<020db442>] ? rcu_process_callbacks+0x178/0x224
[<87626af4>] __do_softirq+0x11c/0x2f8
[<c3f89a50>] ? smpboot_thread_fn+0x4c/0x304
[<c3f89a50>] ? smpboot_thread_fn+0x4c/0x304
[<021b0175>] ? smpboot_thread_fn+0x188/0x304
[<f2e79ebd>] ? smpboot_thread_fn+0x158/0x304
[<966be0e6>] run_ksoftirqd+0x4c/0x80
[<4bf65f60>] smpboot_thread_fn+0x180/0x304
[<3f914d93>] ? _raw_spin_unlock_irqrestore+0x50/0x84
[<bef37779>] ? __kthread_parkme+0x60/0xdc
[<b0798e10>] ? smpboot_thread_fn+0x0/0x304
[<c463cd92>] kthread+0x11c/0x144
[<3eaef0b7>] ? kthread+0x0/0x144
[<ef2f6228>] ret_from_fork+0x1c/0x84

