Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5E15E4BE4
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Oct 2019 15:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394560AbfJYNRi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Oct 2019 09:17:38 -0400
Received: from e2i250.smtp2go.com ([103.2.140.250]:35479 "EHLO
        e2i250.smtp2go.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394559AbfJYNRi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Oct 2019 09:17:38 -0400
X-Greylist: delayed 394 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Oct 2019 09:17:37 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=smtpcorp.com; s=a1-4; h=Feedback-ID:X-Smtpcorp-Track:Date:Message-ID:
        Subject:From:To:Reply-To:Sender:List-Unsubscribe;
        bh=q4wjJf+5O9VgoE1JB/5VkJIJN+YBMHUGAoW59Onzt+Y=; b=aDdezvNFeE3d3BC3uBsgZ4zLVg
        ePIRdO8ESOX3ESY+JOO9x49EYY/DjoYgrBR/MIiIV9KHdUTxX3DAJOrIkq7s52vDcwInvUDvvy8TT
        l9Z+YoYRKgnZ6uk9JCBl9ljjxim3GJhrMv0xE64diRxmJjZwpKhk1ohECeAA0jlwLOzGJQx391d0a
        rDBh/RH3Vhji9ntMwqCWtW9S9HXzcDvXgMth0jTNEuHu9K/y1H12ZmlVAgy0dplqi69RvkWBEa4Qk
        ArePzTdUlhzLz9PLzB71BqmDc0a+SRgRQGLy0AeT3gvoS65S3mMhqVchB2c/AprgxFvRKQxsrLYSz
        EwpWp+TQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linagora.com; 
 i=@linagora.com; q=dns/txt; s=s266739; t=1572009457; 
 h=from : subject : to : message-id : date; 
 bh=q4wjJf+5O9VgoE1JB/5VkJIJN+YBMHUGAoW59Onzt+Y=; 
 b=eAxsV7jnGep+ONSz1mG8xAJJF1RJO6sfdOUuNtVmMGDwT5oTNP6ysxb2
 hs4QExB9/FqXa/RCOXc3H0CbVZxLyE5sBBakO5IsVBThYZqwnLq9p5MRX0
 NSr9xvVOo4mBhTs1Dirg/9MbC0L9AT2jXTCipGtbvcJc+Lnn60dH1KV4w5
 k90Qf3P4HKTFeENGeWN274eHEdzZ3SShwI7zEU70MXdn3Ik8uuPewTZVSh
 BpWKj7fntbKfmurHVIOdU0k1Wcfv+yk64IsxpNGa8RnsW6immx9302/F6a
 OcKe/y0S/iiPWSfdX3bZ4ce2xj3gWulx6bzUztbock8Tq6EuDbkqiw==
Received: from [10.45.33.53] (helo=SmtpCorp)
 by smtpcorp.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92-S2G) (envelope-from <selbaz@linagora.com>)
 id 1iNzMq-Y8PGr8-Ju
 for linux-nfs@vger.kernel.org; Fri, 25 Oct 2019 13:11:00 +0000
Received: from [10.54.36.8] (helo=smtp.linagora.com)
 by smtpcorp.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92-S2G) (envelope-from <selbaz@linagora.com>)
 id 1iNzMo-rlZC02-PH
 for linux-nfs@vger.kernel.org; Fri, 25 Oct 2019 13:10:58 +0000
Received: from [10.75.71.198] (reverse.completel.net [92.103.166.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp.linagora.com (Postfix) with ESMTPSA id D21BC4189E
 for <linux-nfs@vger.kernel.org>; Fri, 25 Oct 2019 15:10:56 +0200 (CEST)
To:     linux-nfs@vger.kernel.org
X-LINAGORA-Copy-Delivery-Done: 1
From:   Simon ELBAZ <selbaz@linagora.com>
Subject: NFS - Permission denied error
Message-ID: <cd936946-f328-b99c-0bdf-c498f569b4ca@linagora.com>
Date:   Fri, 25 Oct 2019 15:10:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------A31F7FB2CA534E2230F50D21"
Content-Language: en-US-large
X-Smtpcorp-Track: 1iNzuor_ZC02eH.skRMPizfX
Feedback-ID: 266739m:266739aja3LFS:266739so8b3k1y0r
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------A31F7FB2CA534E2230F50D21
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

A customer uses:

* RedHat 5.11,
* autofs-5.0.1-0.rc2.184.el5

to intensively access a NFS server from two NFS clients behind an SSH 
haproxy.

The error "Permission denied" happens a few hours later after NFS client 
reboot.
The NFS client is restarted to solve the issue (not the NFS server).

[root@uysubsp06 ~]# su - svsi_tem
su: warning: cannot change directory to /HOME/svsi_tem: Permission denied
$

svsi_tem is an autofs mounted home.

This issue seems similar to http://nfs.sourceforge.net/#section_c, C5 
but i don't know how to debug the eventual /etc/exports misconfiguration.

The exports file sample is attached to the mail. I am focused on the 
following line:

/export/homedirs/svsi                          @SVSI_NFS(rw,sync,insecure)

SVSI_NFS is a map LDAP netgroup.

I proposed the customer to try temporarily the following syntax:

/export/homedirs/svsi 
adresse_IP_host1(rw,sync,insecure) adresse_IP_host2(rw,sync,insecure)

to validate the error diagnostic.

Thanks for any help

Simon

--------------A31F7FB2CA534E2230F50D21
Content-Type: text/plain; charset=UTF-8;
 name="exports"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="exports"

IwovZXhwb3J0L3ByaXZhdGVfZXhwCQkJCXV5c3Vic3AwMyhybyxzeW5jKSB1eXN1YnNwMDQo
cm8sc3luYykKL2V4cG9ydC9wcml2YXRlX3ByagkJCQl1eXN1YnNwMDUocm8sc3luYykgdXlz
dWJzcDA2KHJvLHN5bmMpCi9leHBvcnQvcHJpdmF0ZV9wdG4JCQkJdXlzdWJzcDA3KHJvLHN5
bmMpIHV5c3Vic3AwOChybyxzeW5jKQojCi9leHBvcnQvaG9tZWRpcnMvdGVhbXhpc28vZXBy
b2QJCQl1eXhwbXVyMDEocncsc3luYyxpbnNlY3VyZSkgdXl4cG11cDAxKHJ3LHN5bmMsaW5z
ZWN1cmUpIHVlY3podGgwMShydyxzeW5jLGluc2VjdXJlKSB1ZWN6aHRoMDIocncsc3luYyxp
bnNlY3VyZSkgQFNWU0lfTkZTKHJvLHN5bmMsaW5zZWN1cmUpIHUwMDBqdmkwMShydyxzeW5j
LGluc2VjdXJlKQovZXhwb3J0L2hvbWVkaXJzL3RlYW14aXNvL2Vwcm9kL0xpdnJhYmxlcy9E
ZXZ0CWh5ZHJhKHJ3LHN5bmMsaW5zZWN1cmUpIHUwMDBqdmkwMShydyxzeW5jLGluc2VjdXJl
KQovZXhwb3J0L2hvbWVkaXJzL3RlYW14aXNvL2Vwcm9kX2xvZ3MJCXUwMDBqdmkwMShydyxz
eW5jLGluc2VjdXJlKSBAU1ZTSV9ORlMocncsc3luYyxpbnNlY3VyZSkKL2V4cG9ydC9ob21l
ZGlycy90ZWFteHBhZAkJCUBTVlNJX05GUyhydyxzeW5jLGluc2VjdXJlKQovZXhwb3J0L2hv
bWVkaXJzL3RlYW1lbnZ1CQkJQFNWU0lfTkZTKHJ3LHN5bmMsaW5zZWN1cmUpCi9leHBvcnQv
aG9tZWRpcnMvdGVhbWd0aWEgICAgICAgICAgICAgICAgICAgICAgIEBTVlNJX05GUyhydyxz
eW5jLGluc2VjdXJlKQovZXhwb3J0L2hvbWVkaXJzL3N2c2kJCQkJQFNWU0lfTkZTKHJ3LHN5
bmMsaW5zZWN1cmUpCi9leHBvcnQvaG9tZWRpcnMvdnNjdAkJCQlAU1ZTSV9ORlMocncsc3lu
YyxpbnNlY3VyZSkK
--------------A31F7FB2CA534E2230F50D21--
