Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF9D7814C5
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Aug 2023 23:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbjHRVab (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Aug 2023 17:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240824AbjHRVaF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Aug 2023 17:30:05 -0400
X-Greylist: delayed 1323 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Aug 2023 14:30:02 PDT
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E41421F;
        Fri, 18 Aug 2023 14:30:02 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:54812)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qX6hJ-00Eec7-E9; Fri, 18 Aug 2023 15:07:57 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:41716 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qX6hI-005584-F4; Fri, 18 Aug 2023 15:07:57 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>, linux-hardening@vger.kernel.org,
        Elena Reshetova <elena.reshetova@intel.com>,
        David Windsor <dwindsor@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexey Gladkov <legion@kernel.org>,
        Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, netdev@vger.kernel.org
References: <20230818041740.gonna.513-kees@kernel.org>
        <20230818105542.a6b7c41c47d4c6b9ff2e8839@linux-foundation.org>
        <CAG48ez3mNk8yryV3XHdWZBHC_4vFswJPx1yww+uDi68J=Lepdg@mail.gmail.com>
        <202308181146.465B4F85@keescook>
        <20230818123148.801b446cfdbd932787d47612@linux-foundation.org>
        <e5234e7bd9fbd2531b32d64bc7c23f4753401cee.camel@kernel.org>
        <202308181317.66E6C9A5@keescook>
Date:   Fri, 18 Aug 2023 16:07:49 -0500
In-Reply-To: <202308181317.66E6C9A5@keescook> (Kees Cook's message of "Fri, 18
        Aug 2023 13:24:58 -0700")
Message-ID: <87zg2o5aai.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qX6hI-005584-F4;;;mid=<87zg2o5aai.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+62MLGNsy+flFj/dTZm7oQeFgbyj85fUg=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 407 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 11 (2.7%), b_tie_ro: 9 (2.2%), parse: 1.27 (0.3%),
         extract_message_metadata: 14 (3.4%), get_uri_detail_list: 1.00 (0.2%),
         tests_pri_-2000: 13 (3.2%), tests_pri_-1000: 4.5 (1.1%),
        tests_pri_-950: 1.41 (0.3%), tests_pri_-900: 1.19 (0.3%),
        tests_pri_-200: 0.93 (0.2%), tests_pri_-100: 4.4 (1.1%),
        tests_pri_-90: 68 (16.6%), check_bayes: 66 (16.2%), b_tokenize: 8
        (2.1%), b_tok_get_all: 8 (2.0%), b_comp_prob: 2.7 (0.7%),
        b_tok_touch_all: 43 (10.5%), b_finish: 0.97 (0.2%), tests_pri_0: 193
        (47.3%), check_dkim_signature: 0.68 (0.2%), check_dkim_adsp: 2.5
        (0.6%), poll_dns_idle: 77 (18.9%), tests_pri_10: 2.1 (0.5%),
        tests_pri_500: 89 (21.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2] creds: Convert cred.usage to refcount_t
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Fri, Aug 18, 2023 at 04:10:49PM -0400, Jeff Layton wrote:
>> [...]
>> extra checks (supposedly) compile down to nothing. It should be possible
>> to build alternate refcount_t handling functions that are just wrappers
>> around atomic_t with no extra checks, for folks who want to really run
>> "fast and loose".
>
> No -- there's no benefit for this. We already did all this work years
> ago with the fast vs full break-down. All that got tossed out since it
> didn't matter. We did all the performance benchmarking and there was no
> meaningful difference -- refcount _is_ atomic with an added check that
> is branch-predicted away. Peter Zijlstra and Will Deacon spent a lot of
> time making it run smoothly. :)

Since you did all of the work should the text size of be growing by a
kilobyte for this change?

Is that expected?

That is a valid concern with this change and it really should be
justified in the change long as someone brought it up.

Eric
