Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7D378F09E
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Aug 2023 17:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjHaPxf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Aug 2023 11:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjHaPxf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Aug 2023 11:53:35 -0400
Received: from mail.digitalelves.com (mail.digitalelves.com [198.211.96.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B7521A3
        for <linux-nfs@vger.kernel.org>; Thu, 31 Aug 2023 08:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=thebarn.com;
        s=default; t=1693497182;
        bh=gwWpk3g32WNmT+2Oud2CvqZt37WpighR0o2y2ECLp10=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=dYUYEoLb+WpCBp2lcO2zpyruUDlV8+I1IR/q0T0h58VojrK8SBBH2DmDqsyKzFIT1
         5emXJicM0YpT+RLzLGMrs8y61JCyvHRW/j7XKyl0x91JliiL02bU6tSZGYoNI652jM
         t6K2Pm1IJHgOFlp3Zs6e58m7WvVU6oXDiMlxw0G4=
Received: from [172.30.55.129] (24.77.2fa9.ip4.static.sl-reverse.com [169.47.119.36])
        by mail.digitalelves.com (Postfix) with ESMTPSA id 243EF13B6CD;
        Thu, 31 Aug 2023 15:53:02 +0000 (UTC)
Message-ID: <d5cbff72-6119-060f-4fcf-017b5dd1009d@thebarn.com>
Date:   Thu, 31 Aug 2023 10:53:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: Question on RPC_TASK_NO_RETRANS_TIMEOUT /
 NFS_CS_NO_RETRANS_TIMEOUT for NFSv3
Content-Language: en-US
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <09b207aa-3670-90e8-9a04-1c35c1397a0c@thebarn.com>
 <11a5110b-0769-de07-10a4-d266dbb8c5c0@thebarn.com>
 <cb402253376f2939761169acce1b730bae0e9628.camel@hammerspace.com>
 <56022b0e-08c1-f1da-5509-4e5e9f5a4f7c@thebarn.com>
 <59f26502253a5bc3e359a676d24ed12c7181fee3.camel@hammerspace.com>
From:   Russell Cattelan <cattelan@thebarn.com>
In-Reply-To: <59f26502253a5bc3e359a676d24ed12c7181fee3.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 8/26/23 10:30 AM, Trond Myklebust wrote:

> Yes. For instance the Linux knfsd server will drop requests if the GSS
> sequence number lies outside the window (no, I don't know why it
> doesn't just return RPCSEC_GSS_CTXPROBLEM). It will also happily drop
> deferred requests (i.e. requests waiting for a reply to an upcall) once
> they start piling up. Finally, if the knfsd reply cache says that an
> earlier transmission of the NFSv3 RPC request is still being processed,
> then the new request gets dropped.
> 
>> Wouldn't the rpc code behave the same as v4 and setup a new
>> connection
>> before doing the retrans?
>> At least in our experimentation if we leave the connection down for
>> more
>> 63 seconds we can see from the rpc traces that is what is happening.
>> Once there is a new connection then old message is ignored and
>> processing continues with the new set request / responses.
>>
>>>
>>> The right thing to do is to just fix up rpc_decode_header() to
>>> retry
>>> instead of firing off an error in this case.
>> So you are thinking that rpc_decode_header just returns EAGAIN if the
>> checksum fails?
>> What happens if the GSS context actually goes bad (times out etc)
>> wouldn't that also result in the client get stuck just doing re-sends
>> over and over?
> 
> If the GSS context goes bad, then the server is supposed to return
> either RPCSEC_GSS_CREDPROBLEM (if the server no longer has context for
> that handle) or RPCSEC_GSS_CTXPROBLEM (context is stale due to ticket
> expiry, etc).

Test environment got reset so took a day or so try this.

I change the return when rpcauth_checkverf fails to be a EKEYREJECTED 
error vs EAGAIN

Which puts the decode failure down this path vs just re-transmitting the 
same XID but with a new GSS sequence / checksum.

	case -EKEYREJECTED:
		task->tk_action = call_reserve;
		rpc_check_timeout(task);
		rpcauth_invalcred(task);
		/* Ensure we obtain a new XID if we retry! */
		xprt_release(task);

This does appear to work / address the failure that we are able
to introduce with iptable down ; iptables up.

But question is this a valid thing to do when the gss checksum fails?


diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index ad3e9a40b061..d0bcb6c6b3df 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2645,7 +2645,8 @@ rpc_decode_header(struct rpc_task *task, struct 
xdr_stream *xdr)

  out_verifier:
  	trace_rpc_bad_verifier(task);
-	goto out_garbage;
+	return -EKEYREJECTED;
+	//goto out_garbage;

  out_msg_denied:
  	error = -EACCES;



> 
> If it just times out, then surely the replay cache should ensure that
> it gets processed quickly after a retry, no?
> 
>>
>> I'm really not that up to speed on subtleties of NFS kerberos.
>>
>> Oh note this isn't even krb5p just krb5 mounts. (not that should
>> matter
>> all that much)
>>
>> --Russell Cattelan
> 
