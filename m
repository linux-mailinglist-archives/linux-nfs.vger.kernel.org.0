Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1291561FC9
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2019 15:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731453AbfGHNsj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Jul 2019 09:48:39 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:39094 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbfGHNsj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Jul 2019 09:48:39 -0400
Received: by mail-qt1-f176.google.com with SMTP id l9so9785243qtu.6
        for <linux-nfs@vger.kernel.org>; Mon, 08 Jul 2019 06:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1TTIHuZjhEz5ZZvtNz4JkjvGSpRz80kMurP4N5bPxv4=;
        b=SROjIiWsqTbIupkTzG0DPQ9ScokmrostLZ5WjypIDLMUdILn/p5Ga04ZJaQWSWye2i
         pt09U3bzke1KTeJKpXFpySpLhcXax3mQ8QUbkjs8Z4fWnRH6VSXYPhZ6WsN2K383u9a4
         z04bjDVpncSKRnd61uk8mAEhbU/YD2v/oFgERwmTawemiujWjz4LxfJUhRFc1wqxrO6z
         cLHDgK5mAqfIHUtoezq5Np6mmLvlOYS+oQGCcF5q5icM+ds+Pf4PMhaJCmMKhDPzSigh
         NhhzzlZyB2i82gT/V0FxQh4+8p5cPmVNaijOu43fIm7QQUNvr5xRxE1ukF7NSysQshXc
         QN6w==
X-Gm-Message-State: APjAAAVUGBXL8/AhrWN79G96drGmx377nHKRnJqphMRx2nG2DTrJAyuz
        HMrHHrpbFDcKpPVnW2Grikyin7CFrAw=
X-Google-Smtp-Source: APXvYqzbY6pOHYg2huNQI+jk6Xmv3T92f+3zj8yDCJ1Tp6MlSNAU/3j+z7O3UtFJUCsmFx4lvVr7PQ==
X-Received: by 2002:a0c:fa8b:: with SMTP id o11mr5313101qvn.6.1562593717856;
        Mon, 08 Jul 2019 06:48:37 -0700 (PDT)
Received: from sidious.arb.redhat.com ([12.118.3.106])
        by smtp.gmail.com with ESMTPSA id h18sm7074317qkj.134.2019.07.08.06.48.37
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 06:48:37 -0700 (PDT)
Reply-To: dang@redhat.com
Subject: Re: [Problem]testOpenUpgradeLock test failed in nfsv4.0 in 5.2.0-rc7
To:     Su Yanjun <suyj.fnst@cn.fujitsu.com>, ffilzlnx@mindspring.com
Cc:     linux-nfs@vger.kernel.org
References: <a4ff6e56-09d6-1943-8d71-91eaa418bd1e@cn.fujitsu.com>
 <f105f5a8-d38f-a58a-38d1-6b7a4df4dc9d@cn.fujitsu.com>
From:   Daniel Gryniewicz <dang@redhat.com>
Organization: Red Hat
Message-ID: <89d5612e-9af6-8f2e-15d8-ff6af29d508a@redhat.com>
Date:   Mon, 8 Jul 2019 09:48:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <f105f5a8-d38f-a58a-38d1-6b7a4df4dc9d@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Is this running knfsd or Ganesha as the server?  If it's Ganesha, the 
question would be better asked on the Ganesha Devel list 
devel@lists.nfs-ganesha.org

If it's knfsd, than Frank isn't the right person to ask.

Daniel

On 7/7/19 10:20 PM, Su Yanjun wrote:
> Ang ping?
> 
> 在 2019/7/3 9:34, Su Yanjun 写道:
>> Hi Frank
>>
>> We tested the pynfs of NFSv4.0 on the latest version of the kernel 
>> (5.2.0-rc7).
>> I encountered a problem while testing st_lock.testOpenUpgradeLock. The 
>> problem is now as follows:
>> **************************************************
>> LOCK24 st_lock.testOpenUpgradeLock : FAILURE
>>            OP_LOCK should return NFS4_OK, instead got
>>            NFS4ERR_BAD_SEQID
>> **************************************************
>> Is this normal?
>>
>> The case is as follows:
>> Def testOpenUpgradeLock(t, env):
>>     """Try open, lock, open, downgrade, close
>>
>>     FLAGS: all lock
>>     CODE: LOCK24
>>     """
>>     c= env.c1
>>     C.init_connection()
>>     Os = open_sequence(c, t.code, lockowner="lockowner_LOCK24")
>>     Os.open(OPEN4_SHARE_ACCESS_READ)
>>     Os.lock(READ_LT)
>>     Os.open(OPEN4_SHARE_ACCESS_WRITE)
>>     Os.unlock()
>>     Os.downgrade(OPEN4_SHARE_ACCESS_WRITE)
>>     Os.lock(WRITE_LT)
>>     Os.close()
>>
>> After investigation, there was an error in unlock->lock. When 
>> unlocking, the lockowner of the file was not released, causing an 
>> error when locking again.
>> Will nfs4.0 support 1) open-> 2) lock-> 3) unlock-> 4) lock this 
>> function?
>>
>>
>>
> 
> 

