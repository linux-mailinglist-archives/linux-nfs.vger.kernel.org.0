Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E677A1D85
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Sep 2023 13:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbjIOLgS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Sep 2023 07:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234395AbjIOLgR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Sep 2023 07:36:17 -0400
Received: from mail.cendio.se (dns.cendio.se [IPv6:2a00:801:107:f000::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D381AD
        for <linux-nfs@vger.kernel.org>; Fri, 15 Sep 2023 04:36:07 -0700 (PDT)
Received: from [IPV6:2a00:801:107:4700:cb36:7a86:495f:465b] (unknown [IPv6:2a00:801:107:4700:cb36:7a86:495f:465b])
        by mail.cendio.se (Postfix) with ESMTPSA id BBCAD1835C24;
        Fri, 15 Sep 2023 13:36:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.cendio.se BBCAD1835C24
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cendio.se;
        s=20230315; t=1694777762;
        bh=EELY9HzEvqFZN3cA4NPyFw0E/qsfVEA4VOY2Ft1kF1U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PiEB4kN6sjxAeTcl6nPUrPLnStQ0pXArznD0DIeLwK7N8cbiyFVsacjGgWNbiDgbZ
         XJ32B4I2Ljqi/0WL6AI5eA/yi2re57P9o5kYHXkV5nYcFiqvysGwOGco91WriN/n+l
         an8+YIlkMKiIo8dLmDzOiARudBzyhU7WYxTBClELB2UJRKvRl1Lwj358I2Z/Fsv9z2
         DtO525TO9TGWZKtdrrhFZUi7apz+HGGdOt1L+x9uJtyKI9Mze5WPyIL9M1vsmgzejd
         2JJ1+dXPbetbCLcrAV1UN7ly6zJJKkaCTxTykMSBuYPXvsGbldk/nMM4boiedl1UDJ
         HUxc0pI97TURg==
Content-Type: multipart/mixed; boundary="------------gL1aFXy0ycP93071KSaDIHnp"
Message-ID: <95c31a30-1fc8-6dfa-c16a-c68062900fd9@cendio.se>
Date:   Fri, 15 Sep 2023 13:36:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Stop using deprecated thread.setDaemon
Content-Language: en-US, sv-SE
To:     Calum Mackay <calum.mackay@oracle.com>, bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
References: <20230913104636.2554987-1-alexander.zeijlon@cendio.se>
 <55645fe5-a81f-487a-9694-785b6a1187d1@oracle.com>
From:   Alexander Zeijlon <alexander.zeijlon@cendio.se>
In-Reply-To: <55645fe5-a81f-487a-9694-785b6a1187d1@oracle.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------gL1aFXy0ycP93071KSaDIHnp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi again,

I've fixed a couple more deprecation warnings. See attached patch.

BR,
Alex

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
--------------gL1aFXy0ycP93071KSaDIHnp
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-Stop-using-deprecated-threading-function-aliases.patch"
Content-Disposition: attachment;
 filename*0="0002-Stop-using-deprecated-threading-function-aliases.patch"
Content-Transfer-Encoding: base64

RnJvbSA5MTM3NTM2YTZkOTViZjQ2ZWVhNWNmMzViNTQ5MDI4MDUxOTViOTMwIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4YW5kZXIgWmVpamxvbiA8YWxleGFuZGVyLnpl
aWpsb25AY2VuZGlvLnNlPgpEYXRlOiBGcmksIDE1IFNlcCAyMDIzIDA5OjA3OjQ1ICswMjAw
ClN1YmplY3Q6IFtQQVRDSCAyLzJdIFN0b3AgdXNpbmcgZGVwcmVjYXRlZCB0aHJlYWRpbmcg
ZnVuY3Rpb24tYWxpYXNlcwoKV2Ugd2FudCB0byB1c2UgdGhlIHJlZmVyZW5jZWQgZnVuY3Rp
b25zIGluc3RlYWQgb2YgdGhlaXIgZGVwcmVjYXRlZAphbGlhc2VzLgoKU2lnbmVkLW9mZi1i
eTogQWxleGFuZGVyIFplaWpsb24gPGFsZXhhbmRlci56ZWlqbG9uQGNlbmRpby5zZT4KLS0t
CiBuZnM0LjAvbGliL3JwYy9ycGMucHkgICAgICAgICAgICAgICAgICAgICB8IDE0ICsrKysr
KystLS0tLS0tCiBuZnM0LjAvbGliL3JwYy9ycGNzZWMvc2VjX2F1dGhfZ3NzLnB5ICAgICB8
ICA2ICsrKy0tLQogbmZzNC4xL2xvY2tpbmcucHkgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgOCArKysrLS0tLQogbmZzNC4xL25mczRzdGF0ZS5weSAgICAgICAgICAgICAgICAgICAg
ICAgfCAgNCArKy0tCiBuZnM0LjEvc2VydmVyNDF0ZXN0cy9zdF9jcmVhdGVfc2Vzc2lvbi5w
eSB8ICA0ICsrLS0KIHJwYy9ycGMucHkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgIDIgKy0KIDYgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvbmZzNC4wL2xpYi9ycGMvcnBjLnB5IGIvbmZzNC4wL2xp
Yi9ycGMvcnBjLnB5CmluZGV4IDI0YTdmYzcuLmJkNGIyMGUgMTAwNjQ0Ci0tLSBhL25mczQu
MC9saWIvcnBjL3JwYy5weQorKysgYi9uZnM0LjAvbGliL3JwYy9ycGMucHkKQEAgLTE4Nyw3
ICsxODcsNyBAQCBjbGFzcyBSUENDbGllbnQob2JqZWN0KToKICAgICAgICAgICAgICAgICAg
cHJvZ3JhbT1Ob25lLCB2ZXJzaW9uPU5vbmUsIHNlY19saXN0PU5vbmUsIHRpbWVvdXQ9MTUu
MCwKICAgICAgICAgICAgICAgICAgdXNlbG93cG9ydD1GYWxzZSk6CiAgICAgICAgIHNlbGYu
ZGVidWcgPSAwCi0gICAgICAgIHQgPSB0aHJlYWRpbmcuY3VycmVudFRocmVhZCgpCisgICAg
ICAgIHQgPSB0aHJlYWRpbmcuY3VycmVudF90aHJlYWQoKQogICAgICAgICBzZWxmLmxvY2sg
PSB0aHJlYWRpbmcuTG9jaygpCiAgICAgICAgIHJlcyA9IHNvY2tldC5nZXRhZGRyaW5mbyho
b3N0LCBwb3J0LCAwLCBzb2NrZXQuU09DS19TVFJFQU0pCiAgICAgICAgIHNlbGYuYWYsIHNv
Y2t0eXBlLCBwcm90bywgY2Fubm9ubmFtZSwgc2VsZi5zYSA9IHJlc1swXQpAQCAtMjM0LDcg
KzIzNCw3IEBAIGNsYXNzIFJQQ0NsaWVudChvYmplY3QpOgogICAgICAgICAgICAgICAgICAg
ICByZXR1cm4KIAogICAgIGRlZiBnZXRzb2NrZXQoc2VsZik6Ci0gICAgICAgIHQgPSB0aHJl
YWRpbmcuY3VycmVudFRocmVhZCgpCisgICAgICAgIHQgPSB0aHJlYWRpbmcuY3VycmVudF90
aHJlYWQoKQogICAgICAgICBzZWxmLmxvY2suYWNxdWlyZSgpCiAgICAgICAgIGlmIHQgaW4g
c2VsZi5fc29ja2V0OgogICAgICAgICAgICAgb3V0ID0gc2VsZi5fc29ja2V0W3RdCkBAIC0y
NTAsNyArMjUwLDcgQEAgY2xhc3MgUlBDQ2xpZW50KG9iamVjdCk6CiAgICAgc29ja2V0ID0g
cHJvcGVydHkoZ2V0c29ja2V0KQogCiAgICAgZGVmIGdldHJwY3BhY2tlcihzZWxmKToKLSAg
ICAgICAgdCA9IHRocmVhZGluZy5jdXJyZW50VGhyZWFkKCkKKyAgICAgICAgdCA9IHRocmVh
ZGluZy5jdXJyZW50X3RocmVhZCgpCiAgICAgICAgIHNlbGYubG9jay5hY3F1aXJlKCkKICAg
ICAgICAgaWYgdCBpbiBzZWxmLl9ycGNwYWNrZXI6CiAgICAgICAgICAgICBvdXQgPSBzZWxm
Ll9ycGNwYWNrZXJbdF0KQEAgLTI2MSw3ICsyNjEsNyBAQCBjbGFzcyBSUENDbGllbnQob2Jq
ZWN0KToKICAgICAgICAgcmV0dXJuIG91dAogCiAgICAgZGVmIGdldHJwY3VucGFja2VyKHNl
bGYpOgotICAgICAgICB0ID0gdGhyZWFkaW5nLmN1cnJlbnRUaHJlYWQoKQorICAgICAgICB0
ID0gdGhyZWFkaW5nLmN1cnJlbnRfdGhyZWFkKCkKICAgICAgICAgc2VsZi5sb2NrLmFjcXVp
cmUoKQogICAgICAgICBpZiB0IGluIHNlbGYuX3JwY3VucGFja2VyOgogICAgICAgICAgICAg
b3V0ID0gc2VsZi5fcnBjdW5wYWNrZXJbdF0KQEAgLTI4NCw3ICsyODQsNyBAQCBjbGFzcyBS
UENDbGllbnQob2JqZWN0KToKICAgICAgICAgICAgIHJldHVybiAiJXNcbiVzIiAlIChzZWxm
LmhlYWRlciwgc2VsZi5kYXRhKQogCiAgICAgZGVmIGFkZF9vdXRzdGFuZGluZ194aWRzKHNl
bGYsIHhpZCwgaGVhZGVyLCBkYXRhLCBjcmVkLCBwcm9jKToKLSAgICAgICAgdCA9IHRocmVh
ZGluZy5jdXJyZW50VGhyZWFkKCkKKyAgICAgICAgdCA9IHRocmVhZGluZy5jdXJyZW50X3Ro
cmVhZCgpCiAgICAgICAgIHNlbGYubG9jay5hY3F1aXJlKCkKICAgICAgICAgaWYgdCBpbiBz
ZWxmLl94aWRsaXN0OgogICAgICAgICAgICAgaWYgeGlkIGluIHNlbGYuX3hpZGxpc3RbdF06
IHJhaXNlCkBAIC0yOTQsMTQgKzI5NCwxNCBAQCBjbGFzcyBSUENDbGllbnQob2JqZWN0KToK
ICAgICAgICAgc2VsZi5sb2NrLnJlbGVhc2UoKQogCiAgICAgZGVmIGdldF9vdXRzdGFuZGlu
Z194aWRzKHNlbGYpOgotICAgICAgICB0ID0gdGhyZWFkaW5nLmN1cnJlbnRUaHJlYWQoKQor
ICAgICAgICB0ID0gdGhyZWFkaW5nLmN1cnJlbnRfdGhyZWFkKCkKICAgICAgICAgc2VsZi5s
b2NrLmFjcXVpcmUoKQogICAgICAgICBvdXQgPSBzZWxmLl94aWRsaXN0W3RdCiAgICAgICAg
IHNlbGYubG9jay5yZWxlYXNlKCkKICAgICAgICAgcmV0dXJuIG91dAogCiAgICAgZGVmIHJl
Y29ubmVjdChzZWxmKToKLSAgICAgICAgdCA9IHRocmVhZGluZy5jdXJyZW50VGhyZWFkKCkK
KyAgICAgICAgdCA9IHRocmVhZGluZy5jdXJyZW50X3RocmVhZCgpCiAgICAgICAgIHNlbGYu
bG9jay5hY3F1aXJlKCkKICAgICAgICAgc2VsZi5fc29ja2V0W3RdLmNsb3NlKCkKICAgICAg
ICAgb3V0ID0gc2VsZi5fc29ja2V0W3RdID0gc29ja2V0LnNvY2tldChzZWxmLmFmLCBzb2Nr
ZXQuU09DS19TVFJFQU0pCmRpZmYgLS1naXQgYS9uZnM0LjAvbGliL3JwYy9ycGNzZWMvc2Vj
X2F1dGhfZ3NzLnB5IGIvbmZzNC4wL2xpYi9ycGMvcnBjc2VjL3NlY19hdXRoX2dzcy5weQpp
bmRleCA2NTc3ZmNmLi42MzdiZGJiIDEwMDY0NAotLS0gYS9uZnM0LjAvbGliL3JwYy9ycGNz
ZWMvc2VjX2F1dGhfZ3NzLnB5CisrKyBiL25mczQuMC9saWIvcnBjL3JwY3NlYy9zZWNfYXV0
aF9nc3MucHkKQEAgLTkyLDcgKzkyLDcgQEAgZGVmIGhpbnRfc3RyaW5nKGQpOgogY2xhc3Mg
U2VjQXV0aEdzcyhTZWNGbGF2b3IpOgogICAgIGtyYjVfb2lkID0gIlx4MmFceDg2XHg0OFx4
ODZceGY3XHgxMlx4MDFceDAyXHgwMiIKICAgICBkZWYgX19pbml0X18oc2VsZiwgc2Vydmlj
ZT1ycGNfZ3NzX3N2Y19ub25lKToKLSAgICAgICAgdCA9IHRocmVhZGluZy5jdXJyZW50VGhy
ZWFkKCkKKyAgICAgICAgdCA9IHRocmVhZGluZy5jdXJyZW50X3RocmVhZCgpCiAgICAgICAg
IHNlbGYubG9jayA9IHRocmVhZGluZy5Mb2NrKCkKICAgICAgICAgc2VsZi5nc3Nfc2VxX251
bSA9IDAKICAgICAgICAgc2VsZi5pbml0ID0gMQpAQCAtMTAxLDcgKzEwMSw3IEBAIGNsYXNz
IFNlY0F1dGhHc3MoU2VjRmxhdm9yKToKICAgICAgICAgc2VsZi5fdW5wYWNrZXIgPSB7dCA6
IGdzc19wYWNrLkdTU1VucGFja2VyKCcnKX0KIAogICAgIGRlZiBnZXRwYWNrZXIoc2VsZik6
Ci0gICAgICAgIHQgPSB0aHJlYWRpbmcuY3VycmVudFRocmVhZCgpCisgICAgICAgIHQgPSB0
aHJlYWRpbmcuY3VycmVudF90aHJlYWQoKQogICAgICAgICBzZWxmLmxvY2suYWNxdWlyZSgp
CiAgICAgICAgIGlmIHQgaW4gc2VsZi5fcGFja2VyOgogICAgICAgICAgICAgb3V0ID0gc2Vs
Zi5fcGFja2VyW3RdCkBAIC0xMTIsNyArMTEyLDcgQEAgY2xhc3MgU2VjQXV0aEdzcyhTZWNG
bGF2b3IpOgogICAgICAgICByZXR1cm4gb3V0CiAKICAgICBkZWYgZ2V0dW5wYWNrZXIoc2Vs
Zik6Ci0gICAgICAgIHQgPSB0aHJlYWRpbmcuY3VycmVudFRocmVhZCgpCisgICAgICAgIHQg
PSB0aHJlYWRpbmcuY3VycmVudF90aHJlYWQoKQogICAgICAgICBzZWxmLmxvY2suYWNxdWly
ZSgpCiAgICAgICAgIGlmIHQgaW4gc2VsZi5fdW5wYWNrZXI6CiAgICAgICAgICAgICBvdXQg
PSBzZWxmLl91bnBhY2tlclt0XQpkaWZmIC0tZ2l0IGEvbmZzNC4xL2xvY2tpbmcucHkgYi9u
ZnM0LjEvbG9ja2luZy5weQppbmRleCAyMzhmZGFkLi5jNTk3NTE0IDEwMDY0NAotLS0gYS9u
ZnM0LjEvbG9ja2luZy5weQorKysgYi9uZnM0LjEvbG9ja2luZy5weQpAQCAtMzMsNyArMzMs
NyBAQCBkZWYgX2NvbGxlY3RfYWNxX2RhdGEoc3VmZml4PSIiKToKICAgICAgICAgZGVmIHdy
YXBwZXIoc2VsZik6CiAgICAgICAgICAgICBzdWYgPSAoIiIgaWYgbm90IHN1ZmZpeCBlbHNl
ICJfJXMiICUgc3VmZml4KQogICAgICAgICAgICAgcHJpbnQoIkFDUVVJUkUlcyB0cmllZCBm
b3IgbG9jayAlcyIgJSAoc3VmLnVwcGVyKCksIHNlbGYubmFtZSkpCi0gICAgICAgICAgICB0
ID0gdGhyZWFkaW5nLmN1cnJlbnRUaHJlYWQoKQorICAgICAgICAgICAgdCA9IHRocmVhZGlu
Zy5jdXJyZW50X3RocmVhZCgpCiAgICAgICAgICAgICB0cnk6CiAgICAgICAgICAgICAgICAg
dC5sb2Nrc1tzZWxmLm5hbWVdID0gIndhaXRpbmclcyIgJSBzdWYKICAgICAgICAgICAgIGV4
Y2VwdCBBdHRyaWJ1dGVFcnJvcjoKQEAgLTUwLDcgKzUwLDcgQEAgZGVmIF9jb2xsZWN0X3Jl
bF9kYXRhKHN1ZmZpeD0iIik6CiAgICAgICAgIGRlZiB3cmFwcGVyKHNlbGYsICphcmdzLCAq
Kmt3YXJncyk6CiAgICAgICAgICAgICBzdWYgPSAoIiIgaWYgbm90IHN1ZmZpeCBlbHNlICJf
JXMiICUgc3VmZml4KQogICAgICAgICAgICAgcHJpbnQoIlJFTEVBU0UlcyBsb2NrICVzIiAl
IChzdWYudXBwZXIoKSwgc2VsZi5uYW1lKSkKLSAgICAgICAgICAgIHQgPSB0aHJlYWRpbmcu
Y3VycmVudFRocmVhZCgpCisgICAgICAgICAgICB0ID0gdGhyZWFkaW5nLmN1cnJlbnRfdGhy
ZWFkKCkKICAgICAgICAgICAgIHQubG9ja3Nbc2VsZi5uYW1lXSA9ICJyZWxlYXNlZCVzIiAl
IHN1ZgogICAgICAgICAgICAgcmVsZWFzZShzZWxmLCAqYXJncywgKiprd2FyZ3MpCiAgICAg
ICAgIHJldHVybiB3cmFwcGVyCkBAIC0xMzksNyArMTM5LDcgQEAgY2xhc3MgX1JXTG9jayhv
YmplY3QpOgogICAgICAgICBpZiBub3RpZnkgYW5kIHNlbGYuX3JlYWRfbG9jayA9PSAwOgog
ICAgICAgICAgICAgIyBXZSByZWFsbHkgd2FudCB0byBvbmx5IHdha2Ugb25lIHdyaXRlIHRo
cmVhZCwgYnV0IHRoZXJlCiAgICAgICAgICAgICAjIG1pZ2h0IGJlIHJlYWQgdGhyZWFkcyB3
YWl0aW5nIHRvby4KLSAgICAgICAgICAgIHNlbGYuX2NvbmQubm90aWZ5QWxsKCkKKyAgICAg
ICAgICAgIHNlbGYuX2NvbmQubm90aWZ5X2FsbCgpCiAgICAgICAgIGVsaWYgc2VsZi5fcmVh
ZF9sb2NrIDwgMDoKICAgICAgICAgICAgIHJhaXNlIFZhbHVlRXJyb3IoIlVubWF0Y2hlZCBy
ZWxlYXNlIikKIApAQCAtMTU5LDcgKzE1OSw3IEBAIGNsYXNzIF9SV0xvY2sob2JqZWN0KToK
ICAgICAgICAgc2VsZi5fd3JpdGVfY291bnQgLT0gMQogICAgICAgICBzZWxmLl93cml0ZV9s
b2NrLnJlbGVhc2UoKQogICAgICAgICAjIE11c3QgYWx3YXlzIG5vdGlmeSwgc2luY2UgbWln
aHQgYmUgd3JpdGUtbG9ja2VycyB3YWl0aW5nCi0gICAgICAgIHNlbGYuX2NvbmQubm90aWZ5
QWxsKCkKKyAgICAgICAgc2VsZi5fY29uZC5ub3RpZnlfYWxsKCkKIAogY2xhc3MgX1JXTG9j
a1ZlcmJvc2UoX1JXTG9jayk6CiAgICAgIiIiCmRpZmYgLS1naXQgYS9uZnM0LjEvbmZzNHN0
YXRlLnB5IGIvbmZzNC4xL25mczRzdGF0ZS5weQppbmRleCA2YjRjYzgxLi5hZmMxOWYwIDEw
MDY0NAotLS0gYS9uZnM0LjEvbmZzNHN0YXRlLnB5CisrKyBiL25mczQuMS9uZnM0c3RhdGUu
cHkKQEAgLTU1OCw3ICs1NTgsNyBAQCBjbGFzcyBTdGF0ZVRhYmxlRW50cnkob2JqZWN0KToK
ICAgICAgICAgd2l0aCBzZWxmLl9wcml2YXRlX2xvY2s6CiAgICAgICAgICAgICBzZWxmLnJl
YWRfY291bnQgLT0gMQogICAgICAgICAgICAgaWYgc2VsZi5yZWFkX2NvdW50ICsgc2VsZi53
cml0ZV9jb3VudCA9PSAwOgotICAgICAgICAgICAgICAgIHNlbGYuX3ByaXZhdGVfbG9jay5u
b3RpZnlBbGwoKQorICAgICAgICAgICAgICAgIHNlbGYuX3ByaXZhdGVfbG9jay5ub3RpZnlf
YWxsKCkKIAogICAgIGRlZiBtYXJrX3dyaXRpbmcoc2VsZik6CiAgICAgICAgIHdpdGggc2Vs
Zi5fcHJpdmF0ZV9sb2NrOgpAQCAtNTY4LDcgKzU2OCw3IEBAIGNsYXNzIFN0YXRlVGFibGVF
bnRyeShvYmplY3QpOgogICAgICAgICB3aXRoIHNlbGYuX3ByaXZhdGVfbG9jazoKICAgICAg
ICAgICAgIHNlbGYud3JpdGVfY291bnQgLT0gMQogICAgICAgICAgICAgaWYgc2VsZi53cml0
ZV9jb3VudCArIHNlbGYud3JpdGVfY291bnQgPT0gMDoKLSAgICAgICAgICAgICAgICBzZWxm
Ll9wcml2YXRlX2xvY2subm90aWZ5QWxsKCkKKyAgICAgICAgICAgICAgICBzZWxmLl9wcml2
YXRlX2xvY2subm90aWZ5X2FsbCgpCiAKICAgICBkZWYgd2FpdF91bnRpbF91bnVzZWQoc2Vs
Zik6CiAgICAgICAgICMgT25seSBjYWxsIHRoaXMgaWYgaG9sZGluZyBzZWxmLmxvY2sKZGlm
ZiAtLWdpdCBhL25mczQuMS9zZXJ2ZXI0MXRlc3RzL3N0X2NyZWF0ZV9zZXNzaW9uLnB5IGIv
bmZzNC4xL3NlcnZlcjQxdGVzdHMvc3RfY3JlYXRlX3Nlc3Npb24ucHkKaW5kZXggNDMxNjY0
NC4uZjM4MjkxOCAxMDA2NDQKLS0tIGEvbmZzNC4xL3NlcnZlcjQxdGVzdHMvc3RfY3JlYXRl
X3Nlc3Npb24ucHkKKysrIGIvbmZzNC4xL3NlcnZlcjQxdGVzdHMvc3RfY3JlYXRlX3Nlc3Np
b24ucHkKQEAgLTM0OSw3ICszNDksNyBAQCBkZWYgdGVzdENhbGxiYWNrUHJvZ3JhbSh0LCBl
bnYpOgogICAgICAgICBjID0gZW52LmMxLm5ld19jbGllbnQoZW52LnRlc3RuYW1lKHQpKQog
ICAgICAgICBzZXNzID0gYy5jcmVhdGVfc2Vzc2lvbihwcm9nPXRyYW5zaWVudCkKICAgICAg
ICAgY2Jfb2NjdXJyZWQud2FpdCgxMCkKLSAgICAgICAgaWYgbm90IGNiX29jY3VycmVkLmlz
U2V0KCk6CisgICAgICAgIGlmIG5vdCBjYl9vY2N1cnJlZC5pc19zZXQoKToKICAgICAgICAg
ICAgIGZhaWwoIk5vIENCX05VTEwgc2VudCIpCiAgICAgICAgIGlmIGNiX29jY3VycmVkLnBy
b2cgIT0gdHJhbnNpZW50OgogICAgICAgICAgICAgZmFpbCgiRXhwZWN0ZWQgY2IgcHJvZ2Ft
IDB4JXgsIGdvdCAweCV4IiAlCkBAIC0zNzgsNyArMzc4LDcgQEAgZGVmIHRlc3RDYWxsYmFj
a1ZlcnNpb24odCwgZW52KToKICAgICAgICAgYyA9IGVudi5jMS5uZXdfY2xpZW50KGVudi50
ZXN0bmFtZSh0KSkKICAgICAgICAgc2VzcyA9IGMuY3JlYXRlX3Nlc3Npb24ocHJvZz10cmFu
c2llbnQpCiAgICAgICAgIGNiX29jY3VycmVkLndhaXQoMTApCi0gICAgICAgIGlmIG5vdCBj
Yl9vY2N1cnJlZC5pc1NldCgpOgorICAgICAgICBpZiBub3QgY2Jfb2NjdXJyZWQuaXNfc2V0
KCk6CiAgICAgICAgICAgICBmYWlsKCJObyBDQl9OVUxMIHNlbnQiKQogICAgICAgICBpZiBu
b3QgKGNiX29jY3VycmVkLmxvdyA8PSBjYl9vY2N1cnJlZC52ZXJzIDw9IGNiX29jY3VycmVk
LmhpKToKICAgICAgICAgICAgIGZhaWwoIkV4cGVjdGVkIGNiIHZlcnNpb24gYmV0d2VlbiAl
aSBhbmQgJWksIGdvdCAlaSIgJQpkaWZmIC0tZ2l0IGEvcnBjL3JwYy5weSBiL3JwYy9ycGMu
cHkKaW5kZXggMzYyMWM4ZS4uZGE1OWJmMSAxMDA2NDQKLS0tIGEvcnBjL3JwYy5weQorKysg
Yi9ycGMvcnBjLnB5CkBAIC0xNDgsNyArMTQ4LDcgQEAgY2xhc3MgRGVmZXJyZWREYXRhKG9i
amVjdCk6CiAgICAgZGVmIHdhaXQoc2VsZiwgdGltZW91dD0zMDApOgogICAgICAgICAiIiJX
YWl0IGZvciBkYXRhIHRvIGJlIGZpbGxlZCBpbiIiIgogICAgICAgICBzZWxmLl9maWxsZWQu
d2FpdCh0aW1lb3V0KQotICAgICAgICBpZiBub3Qgc2VsZi5fZmlsbGVkLmlzU2V0KCk6Cisg
ICAgICAgIGlmIG5vdCBzZWxmLl9maWxsZWQuaXNfc2V0KCk6CiAgICAgICAgICAgICByYWlz
ZSBSUENUaW1lb3V0CiAgICAgICAgIGlmIHNlbGYuX2V4Y2VwdGlvbiBpcyBub3QgTm9uZToK
ICAgICAgICAgICAgIHJhaXNlIHNlbGYuX2V4Y2VwdGlvbgotLSAKMi40MS4wCgo=

--------------gL1aFXy0ycP93071KSaDIHnp--
