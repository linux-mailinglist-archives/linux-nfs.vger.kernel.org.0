Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4C22A2CD6
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 15:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgKBOZ6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 09:25:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60383 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725914AbgKBOXG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Nov 2020 09:23:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604326984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YyrfzMnyN3A+ZLQfxeBN6gMhzZ75d7hCyqG2d7xDCm8=;
        b=AgX2yYjXRISHA3X1Gf+drEDUDoKr04fkavbnOKcTaQVrBB1hxAclfNWLT8P+9tB57qunU9
        6yv/nE7tfhBD2cVKY58eX3mzDkAmUKyvGg6GUpmyOstimXYkV3mJ+QbuP7ZZd2CCBQoKTr
        OxWF26ouA1obB1CJ4CkP+PQ/cuAmABc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-b5GTVrFsOSWFxKNrrDDhLQ-1; Mon, 02 Nov 2020 09:23:03 -0500
X-MC-Unique: b5GTVrFsOSWFxKNrrDDhLQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A9348030A4
        for <linux-nfs@vger.kernel.org>; Mon,  2 Nov 2020 14:23:02 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-8.phx2.redhat.com [10.3.113.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C81065B4D0;
        Mon,  2 Nov 2020 14:23:01 +0000 (UTC)
Subject: Re: [RFC PATCH 0/1] Enable config.d directory to be processed.
From:   Steve Dickson <SteveD@RedHat.com>
To:     Alice Mitchell <ajmitchell@redhat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20201029210401.446244-1-steved@redhat.com>
 <338aeb795a31c2233016d225dc114e33d02eb0cb.camel@redhat.com>
 <6f3caf91-296c-0aa8-ba41-bc35d500adaa@RedHat.com>
Message-ID: <4836616f-3aa6-d0bd-22db-cd7fecf4dce9@RedHat.com>
Date:   Mon, 2 Nov 2020 09:23:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <6f3caf91-296c-0aa8-ba41-bc35d500adaa@RedHat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

On 11/2/20 8:24 AM, Steve Dickson wrote:
>> You would need to write an equivalent of conf_load_file() that created
>> a new transaction id and read in all the files before committing them
>> to do it this way.
> I kinda do think we should be able to read in multiple files...
> If that free was not done until all the files are read in, would something
> like that work? I guess I'm ask how difficult would be to re-work
> the code to do something like this. 
> 
Something similar to this... load all the files under the same trans id:
(Compiled tested):
diff --git a/support/nfs/conffile.c b/support/nfs/conffile.c
index c60e511..f003fe1 100644
--- a/support/nfs/conffile.c
+++ b/support/nfs/conffile.c
@@ -578,6 +578,30 @@ static void conf_free_bindings(void)
 	}
 }
 
+static int
+conf_load_files(int trans, const char *conf_file)
+{
+	char *conf_data;
+	char *section = NULL;
+	char *subsection = NULL;
+
+	conf_data = conf_readfile(conf_file);
+	if (conf_data == NULL)
+		return 1;
+
+	/* Load default configuration values.  */
+	conf_load_defaults();
+
+	/* Parse config contents into the transaction queue */
+	conf_parse(trans, conf_data, &section, &subsection, conf_file);
+	if (section) 
+		free(section);
+	if (subsection) 
+		free(subsection);
+	free(conf_data);
+
+	return 0;
+}
 /* Open the config file and map it into our address space, then parse it.  */
 static int
 conf_load_file(const char *conf_file)
@@ -616,6 +640,7 @@ conf_init_dir(const char *conf_file)
 	struct dirent **namelist = NULL;
 	char *dname, fname[PATH_MAX + 1];
 	int n = 0, nfiles = 0, i, fname_len, dname_len;
+	int trans;
 
 	dname = malloc(strlen(conf_file) + 3);
 	if (dname == NULL) {
@@ -637,6 +662,7 @@ conf_init_dir(const char *conf_file)
 		return nfiles;
 	}
 
+	trans = conf_begin();
 	dname_len = strlen(dname);
 	for (i = 0; i < n; i++ ) {
 		struct dirent *d = namelist[i];
@@ -660,11 +686,17 @@ conf_init_dir(const char *conf_file)
 		}
 		sprintf(fname, "%s/%s", dname, d->d_name);
 
-		if (conf_load_file(fname))
+		if (conf_load_files(trans, fname))
 			continue;
 		nfiles++;
 	}
 
+	/* Free potential existing configuration.  */
+	conf_free_bindings();
+
+	/* Apply the new configuration values */
+	conf_end(trans, 1);
+
 	for (i = 0; i < n; i++)
 		free(namelist[i]);
 	free(namelist);

