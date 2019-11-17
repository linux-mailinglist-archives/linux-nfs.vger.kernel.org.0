Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 401F8FFAFD
	for <lists+linux-nfs@lfdr.de>; Sun, 17 Nov 2019 18:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfKQRr3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 17 Nov 2019 12:47:29 -0500
Received: from ny018.relay.arandomserver.com ([172.96.188.180]:35803 "EHLO
        ny018.relay.arandomserver.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726032AbfKQRr2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 17 Nov 2019 12:47:28 -0500
Received: from nyc006.hawkhost.com ([172.96.186.142])
        by se004.arandomserver.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <nazard@nazar.ca>)
        id 1iWOdw-0006G4-QA; Sun, 17 Nov 2019 11:47:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nazar.ca;
         s=default; h=Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:
        Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=EKb6Y0iyKQlQBqK5uXReZaRiJ5Snr4oh3bEf6JKNO30=; b=WeDtKkQJ0f1WppheMJtzuDrm97
        YcVP5O6HUWZHmW5jDunGZMYreGK7rshdEO0I4zP93Psb5gB1+mCMt4DzV45DdT/KdrGfd2mP9/Or9
        5yTgvH3BJPtJ6wkJWz8Qm08RdXPXxCbFau2GDYOgioLbC4W4bCV0VjEv/JZjmgu50+cDGFp8uXM4d
        G9qNkc5V3I2zvuzA79zUB3Fdpykym3FnaAO8Y4Q8uTnqMHcR/SE1cDZwx9/+zlXGkxmOHh42hXqUM
        O6U5Z1MpYNBOxZEPL6ZC6Sugtr5269nsHIPPw1psMz5TZi7qTG+nQw7FvE75asuQonxnkEn7hYhB4
        IbkbteFw==;
Received: from [24.114.54.36] (port=50384 helo=[192.168.21.100])
        by nyc006.hawkhost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <nazard@nazar.ca>)
        id 1iWOdw-00059s-Di; Sun, 17 Nov 2019 12:47:24 -0500
To:     linux-nfs@vger.kernel.org, Steve Dickson <steved@redhat.com>
From:   Doug Nazar <nazard@nazar.ca>
Subject: Re: ANNOUNCE: nfs-utils-2.4.2 released.
Message-ID: <04f375d6-e50a-0b5e-7095-dbc3907bfe23@nazar.ca>
Date:   Sun, 17 Nov 2019 12:47:23 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:71.0) Gecko/20100101
 Thunderbird/71.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------90FC4A4BA1A4B9680F3CEFC5"
Content-Language: en-US
X-AuthUser: nazard@nazar.ca
X-Originating-IP: 172.96.186.142
X-SpamExperts-Domain: nyc006.hawkhost.com
X-SpamExperts-Username: relay
Authentication-Results: arandomserver.com; auth=pass (login) smtp.auth=relay@nyc006.hawkhost.com
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.02)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0fIjBzH0XxYvWQgWH/ix0mSpSDasLI4SayDByyq9LIhVFjtbMnowa8Gq
 vflki7sZrUTNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3K7jpJ6fO8V8ckN3TGhp82q0Aa
 3NMIFR4p3ZtsvmnRoPi3wL2Y4F0412ezGCyTUPanTX+DNB8zzxX/4FjqtJmb5EKE//Lp08muqvHI
 7F+tTvUBzS5fPHINUJxVzZg1ZLp9gmsYntIZvASFzmmwEK8xkpmNQB3hWTYq/vzakcc65ZBQkiNC
 3M7Pj/MY9gGLjh/nwB5YOcnLTEWr5QFxf29u2b0ZFs7AIGlqJcSMQo9hh7aOmrbMWhZFkvyjvYIF
 be8tdb9BwqvSI91oKEKHszPrHLIoTCzQ7XvYo5qydvprZHcSCR22vShmebXILNDFNYkR6LCtYz5o
 yWoRpE2M2XALSMDT9ZG0CmXc0v4tKHsUSjuO8OL3MKmWpyx7GTPK+LOWY5R6BpcvGp3jcY/qUcse
 gxHyS9oTCOMgg0kq/x8Q8jegKor5vGLGjUegAaOB9ePyJLFZV2VsWrEXxYzPJvIeyCEnVSsgPP/M
 gqSGMx92qX+/Ib/3gD1xdv4OjYexFN7ik4oYRgdX/aeSLw4ZD+8uTG/yF5Sslr7rjwGaoPhs3lSG
 05gGM1xqIivRfjxsBj6fkDzLsegeIf5jR5PNTlF6ReCprMAKLZ9Vvl2XZc6+7+zUzX99k5ROK7DU
 2cuVvM4pN2jrzuqNLgr3QpfT+A5/9mbzroJXjH7wQNY/kO3yis9UoFIvD3sIcP1fhJPM6B/8Ije5
 j8YY1/EKr201p+WoIhayBwKtGyHbL7KDmW+I7FsxcfxmM3wdGChc6hHRfRowObH2LW6BIAQW76wb
 eBOhgzcKVNeVJ9BXyu9+ceCqThQaHAwskslMOiSjwnYcoQfxx57gE89ByJNnvoZD/j4xXaiZ9OGv
 SyF6jGxmwlE+D33NBz6C+Mu+hGpwr7PBqmKnubcolFl/rX+2ReQklqJDAdqlKemfur/8qYsUn20e
 BeH3y8h6dUrDs43Vm7LtiRHY
X-Report-Abuse-To: spam@se001.arandomserver.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------90FC4A4BA1A4B9680F3CEFC5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

This still causes crashes in mountd on 32bit systems without 
https://marc.info/?l=linux-nfs&m=157250894818731&w=2

mountd: Version 2.4.2 starting
mountd: auth_unix_ip: inbuf 'nfsd fde2:2b6c:2d24:0021:0000:0000:0000:0050'
mountd: auth_unix_ip: client 0x13cd900 '*'
mountd: nfsd_fh: inbuf '* 6 \xd1fb45ab77b345d99b09b3217dcdf2ec'
*** stack smashing detected ***: <unknown> terminated
Aborted

Call chain looks like:

get_rootfh                    utils/mountd/mountd.c
     check_is_mountpoint       support/misc/mountpoint.c
         nfsd_path_lstat       support/misc/nfsd_path.c    *
             xlstat            support/misc/xstat.c        *

where two struct stats are declared on the stack in mountpoint.c without 
including config.h and getting the __USE_FILE_OFFSET64 define, however 
the following two files in the call chain include config.h and get a 
different size struct stat.

Also attached are a few printf formating fixes for 32 bit.

Doug


--------------90FC4A4BA1A4B9680F3CEFC5
Content-Type: text/plain; charset=UTF-8;
 name="0001-nfsdcld-Fix-printf-format-strings-on-32bit.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-nfsdcld-Fix-printf-format-strings-on-32bit.patch"

RnJvbSBjMzZjZTFhMmE1ZGYwYmI2YTUwMTM5YzFhZTI0NmM0YmFiNmU5MTg0IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBEb3VnIE5hemFyIDxuYXphcmRAbmF6YXIuY2E+CkRh
dGU6IFN1biwgMTcgTm92IDIwMTkgMTI6NDI6MjEgLTA1MDAKU3ViamVjdDogW1BBVENIXSBu
ZnNkY2xkOiBGaXggcHJpbnRmIGZvcm1hdCBzdHJpbmdzIG9uIDMyYml0CgpTaWduZWQtb2Zm
LWJ5OiBEb3VnIE5hemFyIDxuYXphcmRAbmF6YXIuY2E+Ci0tLQogdXRpbHMvbmZzZGNsZC9u
ZnNkY2xkLmMgfCAxNCArKysrKysrLS0tLS0tLQogdXRpbHMvbmZzZGNsZC9zcWxpdGUuYyAg
fCAgNiArKystLS0KIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMTAgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdXRpbHMvbmZzZGNsZC9uZnNkY2xkLmMgYi91dGls
cy9uZnNkY2xkL25mc2RjbGQuYwppbmRleCBiMDY0MzM2ZC4uOTI5N2RmNTEgMTAwNjQ0Ci0t
LSBhL3V0aWxzL25mc2RjbGQvbmZzZGNsZC5jCisrKyBiL3V0aWxzL25mc2RjbGQvbmZzZGNs
ZC5jCkBAIC0zNzgsNyArMzc4LDcgQEAgY2xkX25vdF9pbXBsZW1lbnRlZChzdHJ1Y3QgY2xk
X2NsaWVudCAqY2xudCkKIAlic2l6ZSA9IGNsZF9tZXNzYWdlX3NpemUoY21zZyk7CiAJd3Np
emUgPSBhdG9taWNpbygodm9pZCAqKXdyaXRlLCBjbG50LT5jbF9mZCwgY21zZywgYnNpemUp
OwogCWlmICh3c2l6ZSAhPSBic2l6ZSkKLQkJeGxvZyhMX0VSUk9SLCAiJXM6IHByb2JsZW0g
d3JpdGluZyB0byBjbGQgcGlwZSAoJWxkKTogJW0iLAorCQl4bG9nKExfRVJST1IsICIlczog
cHJvYmxlbSB3cml0aW5nIHRvIGNsZCBwaXBlICglemQpOiAlbSIsCiAJCQkgX19mdW5jX18s
IHdzaXplKTsKIAogCS8qIHJlb3BlbiBwaXBlLCBqdXN0IHRvIGJlIHN1cmUgKi8KQEAgLTQw
OSw3ICs0MDksNyBAQCBjbGRfZ2V0X3ZlcnNpb24oc3RydWN0IGNsZF9jbGllbnQgKmNsbnQp
CiAJeGxvZyhEX0dFTkVSQUwsICJEb2luZyBkb3duY2FsbCB3aXRoIHN0YXR1cyAlZCIsIGNt
c2ctPmNtX3N0YXR1cyk7CiAJd3NpemUgPSBhdG9taWNpbygodm9pZCAqKXdyaXRlLCBjbG50
LT5jbF9mZCwgY21zZywgYnNpemUpOwogCWlmICh3c2l6ZSAhPSBic2l6ZSkgewotCQl4bG9n
KExfRVJST1IsICIlczogcHJvYmxlbSB3cml0aW5nIHRvIGNsZCBwaXBlICglbGQpOiAlbSIs
CisJCXhsb2coTF9FUlJPUiwgIiVzOiBwcm9ibGVtIHdyaXRpbmcgdG8gY2xkIHBpcGUgKCV6
ZCk6ICVtIiwKIAkJCSBfX2Z1bmNfXywgd3NpemUpOwogCQlyZXQgPSBjbGRfcGlwZV9vcGVu
KGNsbnQpOwogCQlpZiAocmV0KSB7CkBAIC00NTksNyArNDU5LDcgQEAgcmVwbHk6CiAJeGxv
ZyhEX0dFTkVSQUwsICJEb2luZyBkb3duY2FsbCB3aXRoIHN0YXR1cyAlZCIsIGNtc2ctPmNt
X3N0YXR1cyk7CiAJd3NpemUgPSBhdG9taWNpbygodm9pZCAqKXdyaXRlLCBjbG50LT5jbF9m
ZCwgY21zZywgYnNpemUpOwogCWlmICh3c2l6ZSAhPSBic2l6ZSkgewotCQl4bG9nKExfRVJS
T1IsICIlczogcHJvYmxlbSB3cml0aW5nIHRvIGNsZCBwaXBlICglbGQpOiAlbSIsCisJCXhs
b2coTF9FUlJPUiwgIiVzOiBwcm9ibGVtIHdyaXRpbmcgdG8gY2xkIHBpcGUgKCV6ZCk6ICVt
IiwKIAkJCSBfX2Z1bmNfXywgd3NpemUpOwogCQlyZXQgPSBjbGRfcGlwZV9vcGVuKGNsbnQp
OwogCQlpZiAocmV0KSB7CkBAIC00OTgsNyArNDk4LDcgQEAgcmVwbHk6CiAJCQljbXNnLT5j
bV9zdGF0dXMpOwogCXdzaXplID0gYXRvbWljaW8oKHZvaWQgKil3cml0ZSwgY2xudC0+Y2xf
ZmQsIGNtc2csIGJzaXplKTsKIAlpZiAod3NpemUgIT0gYnNpemUpIHsKLQkJeGxvZyhMX0VS
Uk9SLCAiJXM6IHByb2JsZW0gd3JpdGluZyB0byBjbGQgcGlwZSAoJWxkKTogJW0iLAorCQl4
bG9nKExfRVJST1IsICIlczogcHJvYmxlbSB3cml0aW5nIHRvIGNsZCBwaXBlICglemQpOiAl
bSIsCiAJCQkgX19mdW5jX18sIHdzaXplKTsKIAkJcmV0ID0gY2xkX3BpcGVfb3BlbihjbG50
KTsKIAkJaWYgKHJldCkgewpAQCAtNTQ4LDcgKzU0OCw3IEBAIHJlcGx5OgogCQkJY21zZy0+
Y21fc3RhdHVzKTsKIAl3c2l6ZSA9IGF0b21pY2lvKCh2b2lkICopd3JpdGUsIGNsbnQtPmNs
X2ZkLCBjbXNnLCBic2l6ZSk7CiAJaWYgKHdzaXplICE9IGJzaXplKSB7Ci0JCXhsb2coTF9F
UlJPUiwgIiVzOiBwcm9ibGVtIHdyaXRpbmcgdG8gY2xkIHBpcGUgKCVsZCk6ICVtIiwKKwkJ
eGxvZyhMX0VSUk9SLCAiJXM6IHByb2JsZW0gd3JpdGluZyB0byBjbGQgcGlwZSAoJXpkKTog
JW0iLAogCQkJIF9fZnVuY19fLCB3c2l6ZSk7CiAJCXJldCA9IGNsZF9waXBlX29wZW4oY2xu
dCk7CiAJCWlmIChyZXQpIHsKQEAgLTYwNyw3ICs2MDcsNyBAQCByZXBseToKIAl4bG9nKERf
R0VORVJBTCwgIkRvaW5nIGRvd25jYWxsIHdpdGggc3RhdHVzICVkIiwgY21zZy0+Y21fc3Rh
dHVzKTsKIAl3c2l6ZSA9IGF0b21pY2lvKCh2b2lkICopd3JpdGUsIGNsbnQtPmNsX2ZkLCBj
bXNnLCBic2l6ZSk7CiAJaWYgKHdzaXplICE9IGJzaXplKSB7Ci0JCXhsb2coTF9FUlJPUiwg
IiVzOiBwcm9ibGVtIHdyaXRpbmcgdG8gY2xkIHBpcGUgKCVsZCk6ICVtIiwKKwkJeGxvZyhM
X0VSUk9SLCAiJXM6IHByb2JsZW0gd3JpdGluZyB0byBjbGQgcGlwZSAoJXpkKTogJW0iLAog
CQkJIF9fZnVuY19fLCB3c2l6ZSk7CiAJCXJldCA9IGNsZF9waXBlX29wZW4oY2xudCk7CiAJ
CWlmIChyZXQpIHsKQEAgLTY2Nyw3ICs2NjcsNyBAQCByZXBseToKIAl4bG9nKERfR0VORVJB
TCwgIkRvaW5nIGRvd25jYWxsIHdpdGggc3RhdHVzICVkIiwgY21zZy0+Y21fc3RhdHVzKTsK
IAl3c2l6ZSA9IGF0b21pY2lvKCh2b2lkICopd3JpdGUsIGNsbnQtPmNsX2ZkLCBjbXNnLCBi
c2l6ZSk7CiAJaWYgKHdzaXplICE9IGJzaXplKSB7Ci0JCXhsb2coTF9FUlJPUiwgIiVzOiBw
cm9ibGVtIHdyaXRpbmcgdG8gY2xkIHBpcGUgKCVsZCk6ICVtIiwKKwkJeGxvZyhMX0VSUk9S
LCAiJXM6IHByb2JsZW0gd3JpdGluZyB0byBjbGQgcGlwZSAoJXpkKTogJW0iLAogCQkJIF9f
ZnVuY19fLCB3c2l6ZSk7CiAJCXJldCA9IGNsZF9waXBlX29wZW4oY2xudCk7CiAJCWlmIChy
ZXQpIHsKZGlmZiAtLWdpdCBhL3V0aWxzL25mc2RjbGQvc3FsaXRlLmMgYi91dGlscy9uZnNk
Y2xkL3NxbGl0ZS5jCmluZGV4IDIzYmU3OTcxLi4wOTUxOGUyMiAxMDA2NDQKLS0tIGEvdXRp
bHMvbmZzZGNsZC9zcWxpdGUuYworKysgYi91dGlscy9uZnNkY2xkL3NxbGl0ZS5jCkBAIC01
MTIsNyArNTEyLDcgQEAgc3FsaXRlX3N0YXJ0dXBfcXVlcnlfZ3JhY2Uodm9pZCkKIAljdXJy
ZW50X2Vwb2NoID0gdGN1cjsKIAlyZWNvdmVyeV9lcG9jaCA9IHRyZWM7CiAJcmV0ID0gMDsK
LQl4bG9nKERfR0VORVJBTCwgIiVzOiBjdXJyZW50X2Vwb2NoPSVsdSByZWNvdmVyeV9lcG9j
aD0lbHUiLAorCXhsb2coRF9HRU5FUkFMLCAiJXM6IGN1cnJlbnRfZXBvY2g9JSJQUkl1NjQi
IHJlY292ZXJ5X2Vwb2NoPSUiUFJJdTY0LAogCQlfX2Z1bmNfXywgY3VycmVudF9lcG9jaCwg
cmVjb3ZlcnlfZXBvY2gpOwogb3V0OgogCXNxbGl0ZTNfZmluYWxpemUoc3RtdCk7CkBAIC0x
MjIzLDcgKzEyMjMsNyBAQCBzcWxpdGVfZ3JhY2Vfc3RhcnQodm9pZCkKIAogCWN1cnJlbnRf
ZXBvY2ggPSB0Y3VyOwogCXJlY292ZXJ5X2Vwb2NoID0gdHJlYzsKLQl4bG9nKERfR0VORVJB
TCwgIiVzOiBjdXJyZW50X2Vwb2NoPSVsdSByZWNvdmVyeV9lcG9jaD0lbHUiLAorCXhsb2co
RF9HRU5FUkFMLCAiJXM6IGN1cnJlbnRfZXBvY2g9JSJQUkl1NjQiIHJlY292ZXJ5X2Vwb2No
PSUiUFJJdTY0LAogCQlfX2Z1bmNfXywgY3VycmVudF9lcG9jaCwgcmVjb3ZlcnlfZXBvY2gp
OwogCiBvdXQ6CkBAIC0xMjgyLDcgKzEyODIsNyBAQCBzcWxpdGVfZ3JhY2VfZG9uZSh2b2lk
KQogCX0KIAogCXJlY292ZXJ5X2Vwb2NoID0gMDsKLQl4bG9nKERfR0VORVJBTCwgIiVzOiBj
dXJyZW50X2Vwb2NoPSVsdSByZWNvdmVyeV9lcG9jaD0lbHUiLAorCXhsb2coRF9HRU5FUkFM
LCAiJXM6IGN1cnJlbnRfZXBvY2g9JSJQUkl1NjQiIHJlY292ZXJ5X2Vwb2NoPSUiUFJJdTY0
LAogCQlfX2Z1bmNfXywgY3VycmVudF9lcG9jaCwgcmVjb3ZlcnlfZXBvY2gpOwogCiBvdXQ6
Ci0tIAoyLjIzLjAKCg==
--------------90FC4A4BA1A4B9680F3CEFC5--
