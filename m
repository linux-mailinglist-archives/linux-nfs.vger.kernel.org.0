Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8960849E242
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jan 2022 13:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241109AbiA0MWf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Jan 2022 07:22:35 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:44548 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241103AbiA0MWf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Jan 2022 07:22:35 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8C54D60F6B67;
        Thu, 27 Jan 2022 13:22:32 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id IlR7MZ9cslD0; Thu, 27 Jan 2022 13:22:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E133D60F6B7A;
        Thu, 27 Jan 2022 13:22:31 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9I09cn8jb155; Thu, 27 Jan 2022 13:22:31 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id BB08360F6B67;
        Thu, 27 Jan 2022 13:22:31 +0100 (CET)
Date:   Thu, 27 Jan 2022 13:22:31 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-nfs <linux-nfs@vger.kernel.org>
Cc:     bfields@fieldses.org, chuck.lever@oracle.com,
        david <david@sigma-star.at>, luis.turcitu@appsbroker.com,
        chris.chilvers@appsbroker.com, david.young@appsbroker.com
Message-ID: <1986873600.300036.1643286151703.JavaMail.zimbra@nod.at>
Subject: NFSD export parsing issue
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF96 (Linux)/8.8.12_GA_3809)
Thread-Index: tZUv125qQuwu7HR24zRIctOgjnMuiA==
Thread-Topic: NFSD export parsing issue
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi!

while experimenting with various modifications in mountd to deal better with crossmounts
I noticed a problem in fs/nfsd/export.c svc_export_parse(), it always ignores the uuid
as provided by my mountd.

If CONFIG_NFSD_V4 is not enabled, both fsloc_parse() and secinfo_parse() are a no-op.
This causes the while loop to terminate prematurely because only the keywords "fsloc" or "secinfo"
got consumed, their parameters are still in the buffer and will trigger the break.

while ((len = qword_get(&mesg, buf, PAGE_SIZE)) > 0) {
        if (strcmp(buf, "fsloc") == 0)
                err = fsloc_parse(&mesg, buf, &exp.ex_fslocs);
        else if (strcmp(buf, "uuid") == 0)
                err = nfsd_uuid_parse(&mesg, buf, &exp.ex_uuid);
        else if (strcmp(buf, "secinfo") == 0)
                err = secinfo_parse(&mesg, buf, &exp);
        else    
                /* quietly ignore unknown words and anything
                 * following. Newer user-space can try to set
                 * new values, then see what the result was.
                 */
                break;  
        if (err)
                goto out4;
}

nfs-utils mountd always places fslock and secinfo before the uuid, no mather
whether I use NFSv4 or v3.

So I'm not sure where to address the problem. Should we fix mountd or
change both fsloc_parse() and secinfo_parse() to consume all their
data even in the !CONFIG_NFSD_V4 case?

Thanks,
//richard
