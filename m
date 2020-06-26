Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF0F20BB9B
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2020 23:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgFZVaY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Jun 2020 17:30:24 -0400
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:49283 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725803AbgFZVaY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Jun 2020 17:30:24 -0400
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1jovvN-0004LW-Q0; Fri, 26 Jun 2020 16:30:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:
        References:Cc:To:Subject:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=rQVGUuTV+cLP33zJlCL5Rp2JBQPMkfcf1DDMtBVBnjA=; b=lNm3x11jsNvYyUrIOjeQ6DZKSt
        RbH7BV//wuSz/ulC6dOODegyTEncRztst6Vf1m2UeGtI+aYcySXXkdnWZy0rHOi6ANd9m3e8nR8me
        tiiAInaThxNzy6pCTKXIPLwdYKKfZ3307ylVUrAyz9LDL0oR8tRIGoi2VoZJ2ztZyXNOgb+54cQGj
        +QO9oc75PrTmoxYly2PgggV7fM1bgzWE9uS11iyBg/BFa5FjZrM3CtMxtk0LEz2nMeEUwP5Zcy26I
        EPh24Lb05/sOTMQc+HEp345UZpNaWh1wIAmY6otgwfC99/O8HN8zT8utkEDCicVG8Osy+nPF56hYc
        LLsiqdOQ==;
Received: from [174.119.114.224] (port=62434 helo=[192.168.21.100])
        by nyc006.hawkhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <nazard@nazar.ca>)
        id 1jovvM-0001yF-9B; Fri, 26 Jun 2020 17:30:16 -0400
Subject: [PATCH v2] Re: Strange segmentation violations of rpc.gssd in Debian
 Buster
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "Kraus, Sebastian" <sebastian.kraus@tu-berlin.de>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>,
        Olga Kornievskaia <aglo@umich.edu>
References: <28a44712b25c4420909360bd813f8bfd@tu-berlin.de>
 <20200620170316.GH1514@fieldses.org>
 <5c45562c90404838944ee71a1d926c74@tu-berlin.de>
 <20200622223628.GC11051@fieldses.org>
 <406fe972135846dc8a23b60be59b0590@tu-berlin.de>
 <1527b158-3404-168c-8908-de4b8a709ccd@nazar.ca>
 <e9de5046e7734e728e64b386314a5d2e@tu-berlin.de>
 <c1c314fd-1855-cf04-3ec5-5f6eb35719a5@nazar.ca>
 <20200626194622.GB11850@fieldses.org>
 <3eb80b1f-e4d3-e87c-aacd-34dc28637948@nazar.ca>
 <20200626210243.GD11850@fieldses.org>
From:   Doug Nazar <nazard@nazar.ca>
Message-ID: <bebca60d-09e4-f118-c195-c6245e6496fb@nazar.ca>
Date:   Fri, 26 Jun 2020 17:30:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200626210243.GD11850@fieldses.org>
Content-Type: multipart/mixed;
 boundary="------------C76790290F3F872CF2D00FA5"
Content-Language: en-US
X-Get-Message-Sender-Via: nyc006.hawkhost.com: authenticated_id: nazard@nazar.ca
X-Authenticated-Sender: nyc006.hawkhost.com: nazard@nazar.ca
X-Originating-IP: 172.96.186.142
X-SpamExperts-Domain: nyc006.hawkhost.com
X-SpamExperts-Username: 172.96.186.142
Authentication-Results: arandomserver.com; auth=pass smtp.auth=172.96.186.142@nyc006.hawkhost.com
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.12)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0f6LF1GdvkEexklpcFpSF5apSDasLI4SayDByyq9LIhVJhm2GOwmKO19
 wDmm9pYrhkTNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3KR4lRsex1/puusHYPsyX5H9tx
 bz3GYvAjJyiUl0OtJpjPBiWknRaZaaGnN6gGyaYwEGP/cqT9NdutmxL11paD9RSJLpr0rbkIUL2o
 EIoo76BEzauJ6YXpjEPQ7tY6Jp26dMYM20ZSLTLtJaZEMmvD/c7Dbkj85KuFQPLurFT3ssmh2yTx
 /diQ6rtfAsExIdyDlww4iRtLrmhscolv/KaRUhkgrBVYrN7YanzFOzWobVxLQy8tYl8J0LAsulR1
 XvL3u+CcQFhF3Ve2xEEkOAAzscANa8quVkvBiHTzhivdHXlWgxmTepC+rmMtfXSN6Ucc1Ez10wji
 WnnY4jRBGidiEoqBnj5U6/fHlgezJ9XnhlGYm6FqIq99D5E8Q5RXzOzL5Tftr1mguUs28jpRgxoQ
 COESyYS1TAnGSFxoa9LQM45/hHmn7zCr7+t8L1Q8S+JfvjG3qIgLxSyrB7IjX9oEa2pNZuMl2RpF
 rF/ORCBqH7EGtpV0foUL7ai8FSlqJ3s51NDVH01yDqixrqvs49JMssEavzt+PYIWFngwZuyqjCbS
 DObWhW6of+A2ttxrz9XWxJeBk/os5j8abOYt1SAwFTiWFYSlhfdXoL2rBaBWqCutI4g+l6rCWbY0
 MZcgnbHsZ1ht3KqvGB1MqKP+ucII3zwOWOdjs8pfb394bdk8bLFOZZWZ1JY6LoDTzqwr/YmPqSgO
 fU86R1qZYeUk9bUzgTkZZY5zsAE0Arxw40k6pMbNbtLtUIjMdb1GvM5tzHodiwQzKw+6v3CaIMG6
 s7LqJBLmYjCOi0cmvn108hito8RsTZSu5kJuva5eg7LJdoHM6y1zz0LVIPvtAv8cWsyd4fO9hgpU
 tCt2tcG8L7AfIec6B5uKB97Duy8oXNoPh0C8GwLLg5ZvYQtTn1uOB16qmsOpyKA69LF1Ge2GaGfx
 mfqLgBN9XPCGAMq9kHVrmjSW7PeJkVKMi5Wvc2RoRDB4klTXXYXYK6IJb19tR0RM6s9OB0fQQI8V
 ICRbS6zGNgmkeXycJ3K3myzhu/bui2AZoafXtaM9VcEKbRMrOhuT3DZOiXVHuYsB8MEITB75Hn54
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------C76790290F3F872CF2D00FA5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2020-06-26 17:02, J. Bruce Fields wrote:
> Unless I'm missing something--an upcall thread could still be using this
> file descriptor.
>
> If we're particularly unlucky, we could do a new open in a moment and
> reuse this file descriptor number, and then then writes in do_downcall()
> could end up going to some other random file.
>
> I think we want these closes done by gssd_free_client() in the !refcnt
> case?

Makes sense. I was thinking more that it was an abort situation and we 
shouldn't be sending any data to the kernel but re-use is definitely a 
concern.

I've split it so that we are removed from the event loop in destroy() 
but the close happens in free().

Doug


--------------C76790290F3F872CF2D00FA5
Content-Type: text/plain; charset=UTF-8;
 name="0001-gssd-Refcount-struct-clnt_info-to-protect-multithrea.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-gssd-Refcount-struct-clnt_info-to-protect-multithrea.pa";
 filename*1="tch"

RnJvbSA4ZWY0OTA4MWU4YTQyYmZhMDViYjYzMjY1Y2Q0Zjk1MWUyYjIzNDEzIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBEb3VnIE5hemFyIDxuYXphcmRAbmF6YXIuY2E+CkRh
dGU6IEZyaSwgMjYgSnVuIDIwMjAgMTY6MDI6MDQgLTA0MDAKU3ViamVjdDogW1BBVENIXSBn
c3NkOiBSZWZjb3VudCBzdHJ1Y3QgY2xudF9pbmZvIHRvIHByb3RlY3QgbXVsdGl0aHJlYWQg
dXNhZ2UKClN0cnVjdCBjbG50X2luZm8gaXMgc2hhcmVkIHdpdGggdGhlIHZhcmlvdXMgdXBj
YWxsIHRocmVhZHMgc28Kd2UgbmVlZCB0byBlbnN1cmUgdGhhdCBpdCBzdGF5cyBhcm91bmQg
ZXZlbiBpZiB0aGUgY2xpZW50IGRpcgpnZXRzIHJlbW92ZWQuCgpSZXBvcnRlZC1ieTogU2Vi
YXN0aWFuIEtyYXVzIDxzZWJhc3RpYW4ua3JhdXNAdHUtYmVybGluLmRlPgpTaWduZWQtb2Zm
LWJ5OiBEb3VnIE5hemFyIDxuYXphcmRAbmF6YXIuY2E+Ci0tLQogdXRpbHMvZ3NzZC9nc3Nk
LmMgICAgICB8IDY3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0t
LQogdXRpbHMvZ3NzZC9nc3NkLmggICAgICB8ICA1ICsrLS0KIHV0aWxzL2dzc2QvZ3NzZF9w
cm9jLmMgfCAgNCArLS0KIDMgZmlsZXMgY2hhbmdlZCwgNTUgaW5zZXJ0aW9ucygrKSwgMjEg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdXRpbHMvZ3NzZC9nc3NkLmMgYi91dGlscy9n
c3NkL2dzc2QuYwppbmRleCA1ODhkYTBmYi4uYjQwYzMyMjAgMTAwNjQ0Ci0tLSBhL3V0aWxz
L2dzc2QvZ3NzZC5jCisrKyBiL3V0aWxzL2dzc2QvZ3NzZC5jCkBAIC05MCw5ICs5MCw3IEBA
IGNoYXIgKmNjYWNoZWRpciA9IE5VTEw7CiAvKiBBdm9pZCBETlMgcmV2ZXJzZSBsb29rdXBz
IG9uIHNlcnZlciBuYW1lcyAqLwogc3RhdGljIGJvb2wgYXZvaWRfZG5zID0gdHJ1ZTsKIHN0
YXRpYyBib29sIHVzZV9nc3Nwcm94eSA9IGZhbHNlOwotaW50IHRocmVhZF9zdGFydGVkID0g
ZmFsc2U7Ci1wdGhyZWFkX211dGV4X3QgcG11dGV4ID0gUFRIUkVBRF9NVVRFWF9JTklUSUFM
SVpFUjsKLXB0aHJlYWRfY29uZF90IHBjb25kID0gUFRIUkVBRF9DT05EX0lOSVRJQUxJWkVS
OworcHRocmVhZF9tdXRleF90IGNscF9sb2NrID0gUFRIUkVBRF9NVVRFWF9JTklUSUFMSVpF
UjsKIAogVEFJTFFfSEVBRCh0b3BkaXJfbGlzdF9oZWFkLCB0b3BkaXIpIHRvcGRpcl9saXN0
OwogCkBAIC0zNTksMjAgKzM1NywyOCBAQCBvdXQ6CiAJZnJlZShwb3J0KTsKIH0KIAorLyog
QWN0dWFsbHkgZnJlZXMgY2xwIGFuZCBmaWVsZHMgdGhhdCBtaWdodCBiZSB1c2VkIGZyb20g
b3RoZXIKKyAqIHRocmVhZHMgaWYgd2FzIGxhc3QgcmVmZXJlbmNlLgorICovCiBzdGF0aWMg
dm9pZAotZ3NzZF9kZXN0cm95X2NsaWVudChzdHJ1Y3QgY2xudF9pbmZvICpjbHApCitnc3Nk
X2ZyZWVfY2xpZW50KHN0cnVjdCBjbG50X2luZm8gKmNscCkKIHsKLQlpZiAoY2xwLT5rcmI1
X2ZkID49IDApIHsKKwlpbnQgcmVmY250OworCisJcHRocmVhZF9tdXRleF9sb2NrKCZjbHBf
bG9jayk7CisJcmVmY250ID0gLS1jbHAtPnJlZmNvdW50OworCXB0aHJlYWRfbXV0ZXhfdW5s
b2NrKCZjbHBfbG9jayk7CisJaWYgKHJlZmNudCA+IDApCisJCXJldHVybjsKKworCXByaW50
ZXJyKDMsICJmcmVlaW5nIGNsaWVudCAlc1xuIiwgY2xwLT5yZWxwYXRoKTsKKworCWlmIChj
bHAtPmtyYjVfZmQgPj0gMCkKIAkJY2xvc2UoY2xwLT5rcmI1X2ZkKTsKLQkJZXZlbnRfZGVs
KCZjbHAtPmtyYjVfZXYpOwotCX0KIAotCWlmIChjbHAtPmdzc2RfZmQgPj0gMCkgeworCWlm
IChjbHAtPmdzc2RfZmQgPj0gMCkKIAkJY2xvc2UoY2xwLT5nc3NkX2ZkKTsKLQkJZXZlbnRf
ZGVsKCZjbHAtPmdzc2RfZXYpOwotCX0KIAotCWlub3RpZnlfcm1fd2F0Y2goaW5vdGlmeV9m
ZCwgY2xwLT53ZCk7CiAJZnJlZShjbHAtPnJlbHBhdGgpOwogCWZyZWUoY2xwLT5zZXJ2aWNl
bmFtZSk7CiAJZnJlZShjbHAtPnNlcnZlcm5hbWUpOwpAQCAtMzgwLDYgKzM4NiwyNCBAQCBn
c3NkX2Rlc3Ryb3lfY2xpZW50KHN0cnVjdCBjbG50X2luZm8gKmNscCkKIAlmcmVlKGNscCk7
CiB9CiAKKy8qIENhbGxlZCB3aGVuIHJlbW92aW5nIGZyb20gY2xudF9saXN0IHRvIHRlYXIg
ZG93biBldmVudCBoYW5kbGluZy4KKyAqIFdpbGwgdGhlbiBmcmVlIGNscCBpZiB3YXMgbGFz
dCByZWZlcmVuY2UuCisgKi8KK3N0YXRpYyB2b2lkCitnc3NkX2Rlc3Ryb3lfY2xpZW50KHN0
cnVjdCBjbG50X2luZm8gKmNscCkKK3sKKwlwcmludGVycigzLCAiZGVzdHJveWluZyBjbGll
bnQgJXNcbiIsIGNscC0+cmVscGF0aCk7CisKKwlpZiAoY2xwLT5rcmI1X2ZkID49IDApCisJ
CWV2ZW50X2RlbCgmY2xwLT5rcmI1X2V2KTsKKworCWlmIChjbHAtPmdzc2RfZmQgPj0gMCkK
KwkJZXZlbnRfZGVsKCZjbHAtPmdzc2RfZXYpOworCisJaW5vdGlmeV9ybV93YXRjaChpbm90
aWZ5X2ZkLCBjbHAtPndkKTsKKwlnc3NkX2ZyZWVfY2xpZW50KGNscCk7Cit9CisKIHN0YXRp
YyB2b2lkIGdzc2Rfc2Nhbih2b2lkKTsKIAogc3RhdGljIGludApAQCAtNDE2LDExICs0NDAs
MjEgQEAgc3RhdGljIHN0cnVjdCBjbG50X3VwY2FsbF9pbmZvICphbGxvY191cGNhbGxfaW5m
byhzdHJ1Y3QgY2xudF9pbmZvICpjbHApCiAJaW5mbyA9IG1hbGxvYyhzaXplb2Yoc3RydWN0
IGNsbnRfdXBjYWxsX2luZm8pKTsKIAlpZiAoaW5mbyA9PSBOVUxMKQogCQlyZXR1cm4gTlVM
TDsKKworCXB0aHJlYWRfbXV0ZXhfbG9jaygmY2xwX2xvY2spOworCWNscC0+cmVmY291bnQr
KzsKKwlwdGhyZWFkX211dGV4X3VubG9jaygmY2xwX2xvY2spOwogCWluZm8tPmNscCA9IGNs
cDsKIAogCXJldHVybiBpbmZvOwogfQogCit2b2lkIGZyZWVfdXBjYWxsX2luZm8oc3RydWN0
IGNsbnRfdXBjYWxsX2luZm8gKmluZm8pCit7CisJZ3NzZF9mcmVlX2NsaWVudChpbmZvLT5j
bHApOworCWZyZWUoaW5mbyk7Cit9CisKIC8qIEZvciBlYWNoIHVwY2FsbCByZWFkIHRoZSB1
cGNhbGwgaW5mbyBpbnRvIHRoZSBidWZmZXIsIHRoZW4gY3JlYXRlIGEKICAqIHRocmVhZCBp
biBhIGRldGFjaGVkIHN0YXRlIHNvIHRoYXQgcmVzb3VyY2VzIGFyZSByZWxlYXNlZCBiYWNr
IGludG8KICAqIHRoZSBzeXN0ZW0gd2l0aG91dCB0aGUgbmVlZCBmb3IgYSBqb2luLgpAQCAt
NDM4LDEzICs0NzIsMTMgQEAgZ3NzZF9jbG50X2dzc2RfY2IoaW50IFVOVVNFRChmZCksIHNo
b3J0IFVOVVNFRCh3aGljaCksIHZvaWQgKmRhdGEpCiAJaW5mby0+bGJ1ZmxlbiA9IHJlYWQo
Y2xwLT5nc3NkX2ZkLCBpbmZvLT5sYnVmLCBzaXplb2YoaW5mby0+bGJ1ZikpOwogCWlmIChp
bmZvLT5sYnVmbGVuIDw9IDAgfHwgaW5mby0+bGJ1ZltpbmZvLT5sYnVmbGVuLTFdICE9ICdc
bicpIHsKIAkJcHJpbnRlcnIoMCwgIldBUk5JTkc6ICVzOiBmYWlsZWQgcmVhZGluZyByZXF1
ZXN0XG4iLCBfX2Z1bmNfXyk7Ci0JCWZyZWUoaW5mbyk7CisJCWZyZWVfdXBjYWxsX2luZm8o
aW5mbyk7CiAJCXJldHVybjsKIAl9CiAJaW5mby0+bGJ1ZltpbmZvLT5sYnVmbGVuLTFdID0g
MDsKIAogCWlmIChzdGFydF91cGNhbGxfdGhyZWFkKGhhbmRsZV9nc3NkX3VwY2FsbCwgaW5m
bykpCi0JCWZyZWUoaW5mbyk7CisJCWZyZWVfdXBjYWxsX2luZm8oaW5mbyk7CiB9CiAKIHN0
YXRpYyB2b2lkCkBAIC00NjEsMTIgKzQ5NSwxMiBAQCBnc3NkX2NsbnRfa3JiNV9jYihpbnQg
VU5VU0VEKGZkKSwgc2hvcnQgVU5VU0VEKHdoaWNoKSwgdm9pZCAqZGF0YSkKIAkJCXNpemVv
ZihpbmZvLT51aWQpKSA8IChzc2l6ZV90KXNpemVvZihpbmZvLT51aWQpKSB7CiAJCXByaW50
ZXJyKDAsICJXQVJOSU5HOiAlczogZmFpbGVkIHJlYWRpbmcgdWlkIGZyb20ga3JiNSAiCiAJ
CQkgInVwY2FsbCBwaXBlOiAlc1xuIiwgX19mdW5jX18sIHN0cmVycm9yKGVycm5vKSk7Ci0J
CWZyZWUoaW5mbyk7CisJCWZyZWVfdXBjYWxsX2luZm8oaW5mbyk7CiAJCXJldHVybjsKIAl9
CiAKIAlpZiAoc3RhcnRfdXBjYWxsX3RocmVhZChoYW5kbGVfa3JiNV91cGNhbGwsIGluZm8p
KQotCQlmcmVlKGluZm8pOworCQlmcmVlX3VwY2FsbF9pbmZvKGluZm8pOwogfQogCiBzdGF0
aWMgc3RydWN0IGNsbnRfaW5mbyAqCkBAIC01MDEsNiArNTM1LDcgQEAgZ3NzZF9nZXRfY2xu
dChzdHJ1Y3QgdG9wZGlyICp0ZGksIGNvbnN0IGNoYXIgKm5hbWUpCiAJY2xwLT5uYW1lID0g
Y2xwLT5yZWxwYXRoICsgc3RybGVuKHRkaS0+bmFtZSkgKyAxOwogCWNscC0+a3JiNV9mZCA9
IC0xOwogCWNscC0+Z3NzZF9mZCA9IC0xOworCWNscC0+cmVmY291bnQgPSAxOwogCiAJVEFJ
TFFfSU5TRVJUX0hFQUQoJnRkaS0+Y2xudF9saXN0LCBjbHAsIGxpc3QpOwogCXJldHVybiBj
bHA7CkBAIC02NTEsNyArNjg2LDcgQEAgZ3NzZF9zY2FuX3RvcGRpcihjb25zdCBjaGFyICpu
YW1lKQogCQlpZiAoY2xwLT5zY2FubmVkKQogCQkJY29udGludWU7CiAKLQkJcHJpbnRlcnIo
MywgImRlc3Ryb3lpbmcgY2xpZW50ICVzXG4iLCBjbHAtPnJlbHBhdGgpOworCQlwcmludGVy
cigzLCAib3JwaGFuZWQgY2xpZW50ICVzXG4iLCBjbHAtPnJlbHBhdGgpOwogCQlzYXZlcHJl
diA9IGNscC0+bGlzdC50cWVfcHJldjsKIAkJVEFJTFFfUkVNT1ZFKCZ0ZGktPmNsbnRfbGlz
dCwgY2xwLCBsaXN0KTsKIAkJZ3NzZF9kZXN0cm95X2NsaWVudChjbHApOwpkaWZmIC0tZ2l0
IGEvdXRpbHMvZ3NzZC9nc3NkLmggYi91dGlscy9nc3NkL2dzc2QuaAppbmRleCBmNGY1OTc1
NC4uZDMzZTRkZmYgMTAwNjQ0Ci0tLSBhL3V0aWxzL2dzc2QvZ3NzZC5oCisrKyBiL3V0aWxz
L2dzc2QvZ3NzZC5oCkBAIC02MywxMiArNjMsMTAgQEAgZXh0ZXJuIHVuc2lnbmVkIGludCAJ
CWNvbnRleHRfdGltZW91dDsKIGV4dGVybiB1bnNpZ25lZCBpbnQgcnBjX3RpbWVvdXQ7CiBl
eHRlcm4gY2hhcgkJCSpwcmVmZXJyZWRfcmVhbG07CiBleHRlcm4gcHRocmVhZF9tdXRleF90
IHBsZV9sb2NrOwotZXh0ZXJuIHB0aHJlYWRfY29uZF90IHBjb25kOwotZXh0ZXJuIHB0aHJl
YWRfbXV0ZXhfdCBwbXV0ZXg7Ci1leHRlcm4gaW50IHRocmVhZF9zdGFydGVkOwogCiBzdHJ1
Y3QgY2xudF9pbmZvIHsKIAlUQUlMUV9FTlRSWShjbG50X2luZm8pCWxpc3Q7CisJaW50CQkJ
cmVmY291bnQ7CiAJaW50CQkJd2Q7CiAJYm9vbAkJCXNjYW5uZWQ7CiAJY2hhcgkJCSpuYW1l
OwpAQCAtOTQsNiArOTIsNyBAQCBzdHJ1Y3QgY2xudF91cGNhbGxfaW5mbyB7CiAKIHZvaWQg
aGFuZGxlX2tyYjVfdXBjYWxsKHN0cnVjdCBjbG50X3VwY2FsbF9pbmZvICpjbHApOwogdm9p
ZCBoYW5kbGVfZ3NzZF91cGNhbGwoc3RydWN0IGNsbnRfdXBjYWxsX2luZm8gKmNscCk7Cit2
b2lkIGZyZWVfdXBjYWxsX2luZm8oc3RydWN0IGNsbnRfdXBjYWxsX2luZm8gKmluZm8pOwog
CiAKICNlbmRpZiAvKiBfUlBDX0dTU0RfSF8gKi8KZGlmZiAtLWdpdCBhL3V0aWxzL2dzc2Qv
Z3NzZF9wcm9jLmMgYi91dGlscy9nc3NkL2dzc2RfcHJvYy5jCmluZGV4IDhmZTY2MDViLi4w
NWMxZGE2NCAxMDA2NDQKLS0tIGEvdXRpbHMvZ3NzZC9nc3NkX3Byb2MuYworKysgYi91dGls
cy9nc3NkL2dzc2RfcHJvYy5jCkBAIC03MzAsNyArNzMwLDcgQEAgaGFuZGxlX2tyYjVfdXBj
YWxsKHN0cnVjdCBjbG50X3VwY2FsbF9pbmZvICppbmZvKQogCXByaW50ZXJyKDIsICJcbiVz
OiB1aWQgJWQgKCVzKVxuIiwgX19mdW5jX18sIGluZm8tPnVpZCwgY2xwLT5yZWxwYXRoKTsK
IAogCXByb2Nlc3Nfa3JiNV91cGNhbGwoY2xwLCBpbmZvLT51aWQsIGNscC0+a3JiNV9mZCwg
TlVMTCwgTlVMTCwgTlVMTCk7Ci0JZnJlZShpbmZvKTsKKwlmcmVlX3VwY2FsbF9pbmZvKGlu
Zm8pOwogfQogCiB2b2lkCkBAIC04MzAsNiArODMwLDYgQEAgaGFuZGxlX2dzc2RfdXBjYWxs
KHN0cnVjdCBjbG50X3VwY2FsbF9pbmZvICppbmZvKQogb3V0OgogCWZyZWUodXBjYWxsX3N0
cik7CiBvdXRfbm9tZW06Ci0JZnJlZShpbmZvKTsKKwlmcmVlX3VwY2FsbF9pbmZvKGluZm8p
OwogCXJldHVybjsKIH0KLS0gCjIuMjYuMgoK
--------------C76790290F3F872CF2D00FA5--
