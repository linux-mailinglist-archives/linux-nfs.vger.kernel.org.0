Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9A279FBCC
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Sep 2023 08:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjINGTs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Sep 2023 02:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjINGTs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Sep 2023 02:19:48 -0400
Received: from mail.cendio.se (dns.cendio.se [IPv6:2a00:801:107:f000::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88543F7
        for <linux-nfs@vger.kernel.org>; Wed, 13 Sep 2023 23:19:44 -0700 (PDT)
Received: from [IPV6:2a00:801:107:4700:cb36:7a86:495f:465b] (unknown [IPv6:2a00:801:107:4700:cb36:7a86:495f:465b])
        by mail.cendio.se (Postfix) with ESMTPSA id D81AF1835C24;
        Thu, 14 Sep 2023 08:19:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.cendio.se D81AF1835C24
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cendio.se;
        s=20230315; t=1694672382;
        bh=b2MwoGTNw3vTCT62zb3PClIvRgFCcZbagwhK+UJsS7E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qXRs3mAq1ItCQOUJRwWRIDJAoN8ZP/Vq/rEFjo6fxndWBdKQXAYnK5hrpFzOpBbZL
         zEz7+l5nKJDn/HjgBNjh8ydOBl9PHIFnSKbyCpog9jZWGSATu2reFd0/Oz7TFmoisI
         N1MFtt7gV5bmSjPoKoCIWBPSdqIBe5Nl6CPXxB4bg1bLuhcuR6kMJCzJFhyoo5ngv9
         uhSMfJ2tFeYGL7Q0g5jRrBQbFXMmEtyYRXR0jMrOFl6het/YPDEH5koDL/Cgu1LC0Y
         6rDYrP9Hp1eA3jvme/uFvk4yyzU6DBvumhM/RBrO1TtvxzKW1tTZ7qJ6dDwhQLE+QN
         2kIEGgNzOruVA==
Message-ID: <e88fcede-054d-201d-d79d-7ff8df90247a@cendio.se>
Date:   Thu, 14 Sep 2023 08:19:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Stop using deprecated thread.setDaemon
To:     Calum Mackay <calum.mackay@oracle.com>, bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
References: <20230913104636.2554987-1-alexander.zeijlon@cendio.se>
 <55645fe5-a81f-487a-9694-785b6a1187d1@oracle.com>
Content-Language: en-US, sv-SE
From:   Alexander Zeijlon <alexander.zeijlon@cendio.se>
In-Reply-To: <55645fe5-a81f-487a-9694-785b6a1187d1@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thank you!

// Alex

On 9/13/23 18:32, Calum Mackay wrote:
> On 13/09/2023 11:46 am, Alexander Zeijlon wrote:
>> The thread.setDaemon method is deprecated since Python version 3.10, the
>> daemon property should now be set directly.
>
> Thanks Alexander, I'll add this to my list.
>
> cheers,
> calum.
>
>>
>> Signed-off-by: Alexander Zeijlon <alexander.zeijlon@cendio.se>
>> ---
>>   nfs4.0/nfs4lib.py                   | 2 +-
>>   nfs4.0/servertests/st_delegation.py | 4 ++--
>>   nfs4.1/nfs4state.py                 | 2 +-
>>   rpc/rpc.py                          | 4 ++--
>>   4 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/nfs4.0/nfs4lib.py b/nfs4.0/nfs4lib.py
>> index 9b074f0..9a72ec9 100644
>> --- a/nfs4.0/nfs4lib.py
>> +++ b/nfs4.0/nfs4lib.py
>> @@ -297,7 +297,7 @@ class NFS4Client(rpc.RPCClient):
>>           # Start up callback server associated with this client
>>           self.cb_server = CBServer(self)
>>           self.thread = threading.Thread(target=self.cb_server.run, 
>> name=name)
>> -        self.thread.setDaemon(True)
>> +        self.thread.daemon = True
>>           self.thread.start()
>>           # Establish callback control socket
>>           self.cb_control = socket.socket(socket.AF_INET, 
>> socket.SOCK_STREAM)
>> diff --git a/nfs4.0/servertests/st_delegation.py 
>> b/nfs4.0/servertests/st_delegation.py
>> index ba49cf9..bcc768a 100644
>> --- a/nfs4.0/servertests/st_delegation.py
>> +++ b/nfs4.0/servertests/st_delegation.py
>> @@ -40,7 +40,7 @@ def _recall(c, thisop, cbid):
>>       if res is not None and res.status != NFS4_OK:
>>           t_error = _handle_error(c, res, ops)
>>           t = threading.Thread(target=t_error.run)
>> -        t.setDaemon(1)
>> +        t.daemon = True
>>           t.start()
>>       return res
>>   @@ -409,7 +409,7 @@ def testChangeDeleg(t, env, funct=_recall):
>>       new_server = CBServer(c)
>>       new_server.set_cb_recall(c.cbid, funct, NFS4_OK);
>>       cb_thread = threading.Thread(target=new_server.run)
>> -    cb_thread.setDaemon(1)
>> +    cb_thread.daemon = True
>>       cb_thread.start()
>>       c.cb_server = new_server
>>       env.sleep(3)
>> diff --git a/nfs4.1/nfs4state.py b/nfs4.1/nfs4state.py
>> index e57b90a..6b4cc81 100644
>> --- a/nfs4.1/nfs4state.py
>> +++ b/nfs4.1/nfs4state.py
>> @@ -308,7 +308,7 @@ class DelegState(FileStateTyped):
>>                   e.status = CB_INIT
>>                   t = threading.Thread(target=e.initiate_recall,
>>                                        args=(dispatcher,))
>> -                t.setDaemon(True)
>> +                t.daemon = True
>>                   t.start()
>>           # We need to release the lock so that delegations can be 
>> recalled,
>>           # which can involve operations like WRITE, LOCK, OPEN, etc,
>> diff --git a/rpc/rpc.py b/rpc/rpc.py
>> index 1fe285a..3621c8e 100644
>> --- a/rpc/rpc.py
>> +++ b/rpc/rpc.py
>> @@ -598,7 +598,7 @@ class ConnectionHandler(object):
>>               log_p.log(5, "Received record from %i" % fd)
>>               log_p.log(2, repr(r))
>>               t = threading.Thread(target=self._event_rpc_record, 
>> args=(r, s))
>> -            t.setDaemon(True)
>> +            t.daemon = True
>>               t.start()
>>         def _event_rpc_record(self, record, pipe):
>> @@ -935,7 +935,7 @@ class Client(ConnectionHandler):
>>             # Start polling
>>           t = threading.Thread(target=self.start, name="PollingThread")
>> -        t.setDaemon(True)
>> +        t.daemon = True
>>           t.start()
>>         def send_call(self, pipe, procedure, data=b'', credinfo=None,
>
