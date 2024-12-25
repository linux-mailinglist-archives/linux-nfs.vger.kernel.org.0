Return-Path: <linux-nfs+bounces-8772-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DDD9FC3DD
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Dec 2024 08:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE33A188189D
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Dec 2024 07:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FA61494A7;
	Wed, 25 Dec 2024 07:02:54 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2370C5A7B8;
	Wed, 25 Dec 2024 07:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735110174; cv=none; b=lz28zMdmm4VLivmicFdd3THrn1MRePXX0gJDBXYpak4r1RuNFutCdsLRtEY4idsE14i8Wq5jz1mkdMN2hmuf7xZtS+QIDQ0cJZY9PGpQGXj9qQgNJUUvAyfdktCXkWDHePOX30qC0fhFE9+vIydE2w4fUk64UQkQO+AXXeE4tQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735110174; c=relaxed/simple;
	bh=6c7GZt2h5/0/ohqsz3xC8bwG3+4ZKfAA/p0od79IWzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X5rcFofwPM4BKGkp6zDlpKOq5ILpcyYB9wS/Et+pbjrxp4ZzvXjYH+9+5rPL+W0juvbDsTbZdDiyjqqTs4M4D1dNny4T7jlMIvrlLE8+eM7q6rfCO0ALlgr5esACOos23PKlrcJr0Hb/pJIA4x0vS4g2H4jMkAZQXtT2ikZD+E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YJ2kp3gL0z4f3lDN;
	Wed, 25 Dec 2024 15:02:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4C1BB1A0197;
	Wed, 25 Dec 2024 15:02:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgAHL4MRrmtnO8dPFg--.38269S4;
	Wed, 25 Dec 2024 15:02:46 +0800 (CST)
From: Yang Erkun <yangerkun@huawei.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trondmy@kernel.org,
	anna@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	yangerkun@huawei.com,
	yangerkun@huaweicloud.com,
	liumingrui@huawei.com
Subject: [PATCH v2 0/4] nfsd/sunrpc: cleanup resource with sync mode
Date: Wed, 25 Dec 2024 14:59:04 +0800
Message-ID: <20241225065908.1547645-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHL4MRrmtnO8dPFg--.38269S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4rWF18uFWxCFy8CryxuFg_yoW8Ar1UpF
	Z3ArZxKr4kWFWakan3Ca1UXFyrWrZYyw1xJ3Z2qw4Fvw1rur18Gwn0yF40934qqFyrG3y2
	qr10qFy5CF1DAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0aVACjI8F5VA0II8E6IAqYI8I648v4I1l
	FIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr4
	1l42xK82IY64kExVAvwVAq07x20xyl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
	WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU0sq
	XJUUUUU==
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

After f8c989a0c89a ("nfsd: release svc_expkey/svc_export with
rcu_work"), svc_export_put/expkey_put will call path_put with async
mode. This can lead some unexpected failure:

mkdir /mnt/sda
mkfs.xfs -f /dev/sda
echo "/ *(rw,no_root_squash,fsid=0)" > /etc/exports
echo "/mnt *(rw,no_root_squash,fsid=1)" >> /etc/exports
exportfs -ra
service nfs-server start
mount -t nfs -o vers=4.0 127.0.0.1:/mnt /mnt1
mount /dev/sda /mnt/sda
touch /mnt1/sda/file
exportfs -r
umount /mnt/sda # failed unexcepted

The touch above will finally call nfsd_cross_mnt, add refcount to mount,
and then add cache_head. Before this commit, exportfs -r will call
cache_flush to cleanup all cache_head, and path_put in
svc_export_put/expkey_put will be finished with sync mode. So, the
latter umount will always success. However, after this commit, path_put
will be called with async mode, the latter umount may failed, and if we
add some delay, umount will success too. Personally I think this bug and
should be fixed. We first revert before bugfix patch, and then fix the
original bug with a different way.

v1->v2:

1. do not change cache_check, instead add cache_check_rcu and use it in
c_show/e_show
2. the first patch has been applied

Yang Erkun (4):
  SUNRPC: introduce cache_check_rcu to help check in rcu context
  nfsd: no need get cache ref when protected by rcu
  SUNRPC: no need get cache ref when protected by rcu
  nfsd: fix UAF when access ex_uuid or ex_stats

 fs/nfsd/export.c             | 25 ++++++++++-------
 include/linux/sunrpc/cache.h |  2 ++
 net/sunrpc/cache.c           | 53 ++++++++++++++++++++----------------
 3 files changed, 46 insertions(+), 34 deletions(-)

-- 
2.46.1


